//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import "GRFXBookmark.h"
#import "GRFXEntry.h"


@implementation GRFXBookmark
{

@private
    NSInteger _id;
    GRFXEntry *_entry;
}
@synthesize id = _id;
@synthesize entry = _entry;

- (id)initWithId:(NSInteger)id entry:(GRFXEntry *)entry
{
    self = [super init];
    if (self)
    {
        _id = id;
        _entry = entry;
    }
    return self;
}

@end