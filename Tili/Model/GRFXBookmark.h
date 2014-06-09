//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRFXNote;


@interface GRFXBookmark : NSObject
@property NSInteger id;
@property GRFXNote *note;

- (id)initWithId:(NSInteger)id Note:(GRFXNote *)note;
@end