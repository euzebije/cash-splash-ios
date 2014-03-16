//
//  CSSaveSpendingTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLocalDataManager.h"
#import "CSDatePickerViewController.h"
#import "CSCategoryPickerTableViewController.h"
#import "CSLabelPickerTableViewController.h"

@interface CSSaveSpendingTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, CSDatePickerDelegate, CSCategoryPickerDelegate, CSLabelPickerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;

- (IBAction)noteEditEnd:(id)sender;
@end
