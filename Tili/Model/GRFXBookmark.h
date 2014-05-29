//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRFXSearchResult;


@interface GRFXBookmark : NSObject
@property NSInteger id;
@property GRFXSearchResult *note;

- (id)initWithId:(NSInteger)id Note:(GRFXSearchResult *)note;
@end