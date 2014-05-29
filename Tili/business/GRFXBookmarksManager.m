//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import "GRFXBookmarksManager.h"
#import "GRFXSearchResult.h"
#import "FMDatabase.h"
#import "GRFXBookmark.h"


@implementation GRFXBookmarksManager
{
    FMDatabase *_database;
@private
    NSArray *_bookmarks;
}
@synthesize bookmarks = _bookmarks;

+ (GRFXBookmarksManager *)sharedManager
{
    static dispatch_once_t once_t;
    static GRFXBookmarksManager *bookmarks;
    dispatch_once(&once_t, ^
    {
        bookmarks = [GRFXBookmarksManager new];
    });
    return bookmarks;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _database = [self openDatabase];
    }

    return self;
}

- (FMDatabase *)openDatabase
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documents_dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *db_path = [documents_dir stringByAppendingPathComponent:[NSString stringWithFormat:@"bookmarks.sqlite"]];
    NSString *template_path = [[NSBundle mainBundle] pathForResource:@"bookmarks" ofType:@"sqlite"];

    if (![fm fileExistsAtPath:db_path])
    {
        [fm copyItemAtPath:template_path toPath:db_path error:nil];
    }

    FMDatabase *db = [FMDatabase databaseWithPath:db_path];
    if (![db open])
    {
        NSLog(@"Failed to open database!");
    }
    return db;
}

- (NSArray *)bookmarks
{
    if (!_bookmarks)
    {
        _bookmarks = [self readBookmarks];
    }
    return _bookmarks;
}

- (NSArray *)readBookmarks
{
    NSString *sql = @"SELECT * FROM bookmarks";
    FMResultSet *result = [_database executeQuery:sql];
    NSMutableArray *bookmarks = [NSMutableArray new];
    while ([result next])
    {
        GRFXSearchResult *note = [GRFXSearchResult new];
        note.value = [result stringForColumn:@"text_value"];
        note.dictname = [result stringForColumn:@"dictionaries"];
        note.keyword = [result stringForColumn:@"search_word"];
        NSInteger bookmarkId = [result intForColumn:@"id"];
        GRFXBookmark *bookmark = [[GRFXBookmark alloc] initWithId:bookmarkId Note:note];
        [bookmarks addObject:bookmark];
    }

    return bookmarks;
}

- (void)saveBookmark:(GRFXSearchResult *)bookmark
{

}

- (void)removeBookmark:(GRFXSearchResult *)bookmark
{

}


@end