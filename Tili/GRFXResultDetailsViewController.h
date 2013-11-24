//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class GRFXSearchResult;


@interface GRFXResultDetailsViewController : UIViewController <UIWebViewDelegate>
@property(weak) IBOutlet UIWebView *webView;
@property GRFXSearchResult *searchResult;
@end