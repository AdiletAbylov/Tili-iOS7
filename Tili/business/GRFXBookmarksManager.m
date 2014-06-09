//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import "GRFXBookmarksManager.h"
#import "GRFXEntry.h"
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

    return [self readBookmarks];
}

- (NSArray *)readBookmarks
{
    NSString *sql = @"SELECT * FROM bookmarks";
    FMResultSet *result = [_database executeQuery:sql];
    NSMutableArray *bookmarks = [NSMutableArray new];
    while ([result next])
    {
        GRFXEntry *note = [GRFXEntry new];
        note.text = [result stringForColumn:@"text_value"];
        note.dictionaryName = [result stringForColumn:@"dictionaries"];
        note.keyword = [result stringForColumn:@"search_word"];
        NSInteger bookmarkId = [result intForColumn:@"id"];
        GRFXBookmark *bookmark = [[GRFXBookmark alloc] initWithId:bookmarkId entry:note];
        [bookmarks addObject:bookmark];
    }

    return bookmarks;
}

- (void)saveEntry:(GRFXEntry *)bookmark
{
    NSString *sql = @"INSERT INTO bookmarks (text_value, dictionaries, search_word) VALUES(?,?,?)";
    BOOL updated = [_database executeUpdate:sql, bookmark.text, bookmark.dictionaryName, bookmark.keyword];
    if (!updated)
    {
        NSLog(@"Insert fail");
    }

}

- (void)removeBookmark:(GRFXEntry *)bookmark
{

}


@end