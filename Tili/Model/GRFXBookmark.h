//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRFXEntry;


@interface GRFXBookmark : NSObject
@property NSInteger id;
@property GRFXEntry *entry;

- (id)initWithId:(NSInteger)id entry:(GRFXEntry *)entry;
@end