//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRFXEntry;


@interface GRFXBookmarksManager : NSObject
+ (GRFXBookmarksManager *)sharedManager;

@property(nonatomic, readonly) NSArray *bookmarks;

- (void)saveEntry:(GRFXEntry *)bookmark;

- (void)removeBookmark:(GRFXEntry *)bookmark;
@end