//
// Created by Adilet Abylov on 11/23/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class GRFXEntry;


@interface GRFXResultsCell : UITableViewCell
@property (weak) IBOutlet UILabel *titleWordLabel;
@property (weak) IBOutlet UILabel *spoilerLabel;
@property (weak) IBOutlet UILabel *dictionaryLabel;

-(void)fillCellWithSearchResult:(GRFXEntry *)searchResult;
@end