//
//  GRFXMainViewController.m
//  Tili
//
//  Created by Adilet Abylov on 11/23/13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "GRFXMainViewController.h"
#import "GRFXResultsCell.h"
#import "GRFXSearchResult.h"
#import "GRFXResultDetailsViewController.h"
#import "SVProgressHUD.h"

@interface GRFXMainViewController ()

@end

@implementation GRFXMainViewController
{
    GRFXSearchProxy *_searchProxy;
    NSString *_searchingWord;
    NSArray *_results;
@private
    __weak UITableView *_tableView;
    __weak UITextField *_searchTextField;
}

@synthesize tableView = _tableView;

@synthesize searchTextField = _searchTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _searchTextField.delegate = self;
    [[self navigationController] setNavigationBarHidden:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initSearchProxy];

    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


- (void)initSearchProxy
{
    _searchProxy = [GRFXSearchProxy new];
    _searchProxy.delegate = self;
}


- (void)searchProxyDidSuccessWithResults:(NSArray *)results
{
    [SVProgressHUD dismiss];
    _results = results;
    [_tableView reloadData];
}

- (void)searchProxyDidFailWithErrorString:(NSString *)errorString
{
    [SVProgressHUD showErrorWithStatus:errorString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _results.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_results)
    {
        return [NSString stringWithFormat:@"%d результатов для слова %@", _results.count, _searchingWord];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const NSString *cellID = @"ResultsCell";
    GRFXResultsCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    GRFXSearchResult *searchResult = [_results objectAtIndex:indexPath.row];
    [cell fillCellWithSearchResult:searchResult];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DetailsSegue" sender:self];
    [self hideKeyboard];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GRFXResultDetailsViewController *controller = segue.destinationViewController;
    GRFXSearchResult *searchResult = [_results objectAtIndex:[_tableView indexPathForSelectedRow].row];
    controller.searchResult = searchResult;
}

- (IBAction)didTapSearch:(id)sender
{
    [self startSearch];
}

-(void)startSearch
{
    if(![_searchTextField.text isEqualToString:@""])
    {
        [_searchProxy searchWord:_searchTextField.text];
        _searchingWord = _searchTextField.text;
        [self hideKeyboard];
        [SVProgressHUD showWithStatus:@"Поиск..."];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self startSearch];
    [self hideKeyboard];
    return YES;
}

-(void)hideKeyboard
{
    [_searchTextField resignFirstResponder];
}

@end
