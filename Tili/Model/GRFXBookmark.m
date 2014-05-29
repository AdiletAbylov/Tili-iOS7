//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import "GRFXBookmark.h"
#import "GRFXSearchResult.h"


@implementation GRFXBookmark
{

}
- (id)initWithId:(NSInteger)id Note:(GRFXSearchResult *)note
{
    self = [super init];
    if (self)
    {
        self.id = id;
        self.note = note;
    }
    return self;
}

@end