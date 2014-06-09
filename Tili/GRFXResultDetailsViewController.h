//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class GRFXNote;


@interface GRFXResultDetailsViewController : UIViewController <UIWebViewDelegate>
@property(weak) IBOutlet UIWebView *webView;
@property GRFXNote *searchResult;
@property BOOL isBookmarked;

- (IBAction)didTouchBookmarkButton:(id)sender;
@end