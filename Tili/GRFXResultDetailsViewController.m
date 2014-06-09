//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXResultDetailsViewController.h"
#import "GRFXNote.h"
#import "GRFXBookmarksManager.h"
#import "SVProgressHUD.h"


@implementation GRFXResultDetailsViewController
{

@private

    GRFXNote *_searchResult;
    __weak UIWebView *_webView;
    BOOL _isBookmarked;
}

@synthesize searchResult = _searchResult;

@synthesize webView = _webView;


@synthesize isBookmarked = _isBookmarked;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _searchResult.keyword;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_webView loadHTMLString:[self htmlTextForSearchResult:_searchResult] baseURL:nil];
    if (_isBookmarked)
    {
        UIBarButtonItem *removeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(didTouchBookmarkButton:)];
        self.navigationItem.rightBarButtonItem = removeItem;
    } else
    {
        UIBarButtonItem *bookmarkItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(didTouchBookmarkButton:)];
        self.navigationItem.rightBarButtonItem = bookmarkItem;
    }
}


- (NSString *)htmlTextForSearchResult:(GRFXNote *)searchResult
{
    NSString *value = [searchResult.value stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    NSString *htmlText = [NSString stringWithFormat:@"<html>"
                                                            "<head><style type=\"text/css\"> body {font-family: \"HelveticaNeue-Light\"; font-size: 12;}</style>"
                                                            "</head>"
                                                            "<body><H1>%@</H1><i>%@</i><p>%@</p></body></html>",
                                                    searchResult.keyword, searchResult.dictname, value];
    return htmlText;
}

- (IBAction)didTouchBookmarkButton:(id)sender
{
    [SVProgressHUD showWithStatus:@"Сохранение"];
    [[GRFXBookmarksManager sharedManager] saveNote:_searchResult];
    [SVProgressHUD dismiss];
}

@end