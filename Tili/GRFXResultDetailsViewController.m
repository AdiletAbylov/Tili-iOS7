//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXResultDetailsViewController.h"
#import "GRFXEntry.h"
#import "GRFXBookmarksManager.h"
#import "SVProgressHUD.h"


@implementation GRFXResultDetailsViewController
{

@private

    GRFXEntry *_entry;
    __weak UIWebView *_webView;
    BOOL _bookmarked;
}

@synthesize entry = _entry;

@synthesize webView = _webView;


@synthesize bookmarked = _bookmarked;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _entry.keyword;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_webView loadHTMLString:[self htmlTextForEntry:_entry] baseURL:nil];
    if (!_bookmarked)
    {
        UIBarButtonItem *bookmarkItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(didTouchBookmarkButton:)];
        self.navigationItem.rightBarButtonItem = bookmarkItem;
    }
}


- (NSString *)htmlTextForEntry:(GRFXEntry *)entry
{
    NSString *value = [entry.text stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    NSString *htmlText = [NSString stringWithFormat:@"<html>"
                                                            "<head><style type=\"text/css\"> body {font-family: \"HelveticaNeue-Light\"; font-size: 12;}</style>"
                                                            "</head>"
                                                            "<body><H1>%@</H1><i>%@</i><p>%@</p></body></html>",
                                                    entry.keyword, entry.dictionaryName, value];
    return htmlText;
}

- (IBAction)didTouchBookmarkButton:(id)sender
{
    [SVProgressHUD showWithStatus:@"Сохранение"];
    [[GRFXBookmarksManager sharedManager] saveEntry:_entry];
    [SVProgressHUD dismiss];
}


@end