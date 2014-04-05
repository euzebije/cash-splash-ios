//
//  CSSaveSpendingTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSTablePickerViewController.h"
#import "CSDatePickerViewController.h"

@interface CSSaveSpendingTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, CSTablePickerDelegate, CSDatePickerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;

- (IBAction)noteEditEnd:(id)sender;
- (IBAction)saveTapped:(id)sender;

@end
