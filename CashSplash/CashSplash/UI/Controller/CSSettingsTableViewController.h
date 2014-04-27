//
//  CSSettingsTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSSettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *useDropboxSwitch;

- (IBAction)useDropboxChanged:(id)sender;

@end
