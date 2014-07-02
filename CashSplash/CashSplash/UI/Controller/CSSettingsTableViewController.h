//
//  CSSettingsTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTablePickerViewController.h"

@interface CSSettingsTableViewController : UITableViewController <CSTablePickerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *useDropboxSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dataDisplayDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)useDropboxChanged:(id)sender;

@end
