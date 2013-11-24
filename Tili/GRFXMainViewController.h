//
//  GRFXMainViewController.h
//  Tili
//
//  Created by Adilet Abylov on 11/23/13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRFXSearchProxy.h"

@interface GRFXMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GRFXSearchProxyDelegate, UITextFieldDelegate>
@property(weak) IBOutlet UITableView *tableView;
@property(weak) IBOutlet UITextField *searchTextField;

- (IBAction)didTapSearch:(id)sender;
@end
