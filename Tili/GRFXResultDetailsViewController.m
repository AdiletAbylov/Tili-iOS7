//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXResultDetailsViewController.h"
#import "GRFXSearchResult.h"


@implementation GRFXResultDetailsViewController
{

@private

    GRFXSearchResult *_searchResult;
    __weak UIWebView *_webView;
}

@synthesize searchResult = _searchResult;

@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _searchResult.keyword;
    [_webView loadHTMLString:[self htmlTextForSearchResult:_searchResult] baseURL:nil];
}



- (NSString *)htmlTextForSearchResult:(GRFXSearchResult *)searchResult
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

}

@end