//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRFXSearchResult;


@interface GRFXBookmarksManager : NSObject
+ (GRFXBookmarksManager *)sharedManager;

@property(nonatomic, readonly) NSArray *bookmarks;

- (void)saveBookmark:(GRFXSearchResult *)bookmark;

- (void)removeBookmark:(GRFXSearchResult *)bookmark;
@end