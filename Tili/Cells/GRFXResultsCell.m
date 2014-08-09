//
// Created by Adilet Abylov on 11/23/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXResultsCell.h"
#import "GRFXEntry.h"


@implementation GRFXResultsCell
{

@private
    __weak UILabel *_titleWordLabel;
    __weak UILabel *_spoilerLabel;
    __weak UILabel *_dictionaryLabel;
}
@synthesize titleWordLabel = _titleWordLabel;
@synthesize spoilerLabel = _spoilerLabel;
@synthesize dictionaryLabel = _dictionaryLabel;

- (void)fillCellWithSearchResult:(GRFXEntry *)searchResult
{
    _titleWordLabel.text = searchResult.keyword;
    _spoilerLabel.text = searchResult.text;
    _dictionaryLabel.text = searchResult.dictionaryName;
}

@end