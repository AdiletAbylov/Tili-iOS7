//
// Created by Adilet Abylov on 5/29/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import "GRFXBookmarksViewController.h"
#import "GRFXBookmarksManager.h"
#import "GRFXResultsCell.h"
#import "GRFXResultDetailsViewController.h"
#import "GRFXBookmark.h"


@implementation GRFXBookmarksViewController
{
    NSArray *_bookmarks;

@private
    __weak UITableView *_tableView;
}
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _bookmarks = [GRFXBookmarksManager sharedManager].bookmarks;
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bookmarks.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_bookmarks)
    {
        return [NSString stringWithFormat:@"%d сохраненных слов", _bookmarks.count];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const NSString *cellID = @"ResultsCell";
    GRFXResultsCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    GRFXNote *searchResult = ((GRFXBookmark *) [_bookmarks objectAtIndex:indexPath.row]).note;
    [cell fillCellWithSearchResult:searchResult];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRFXResultDetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
    GRFXNote *searchResult = ((GRFXBookmark *) [_bookmarks objectAtIndex:indexPath.row]).note;
    controller.searchResult = searchResult;
    controller.hidesBottomBarWhenPushed = YES;
    controller.isBookmarked = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


@end