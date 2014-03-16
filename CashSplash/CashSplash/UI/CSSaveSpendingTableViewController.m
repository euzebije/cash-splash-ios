//
//  CSSaveSpendingTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSaveSpendingTableViewController.h"

@implementation CSSaveSpendingTableViewController
{
    NSString *_category;
    NSString *_label;
    NSDate *_date;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.amountPicker.dataSource = self;
    self.amountPicker.delegate = self;
    
    [self setDate:[NSDate date]];
}

- (IBAction)noteEditEnd:(id)sender
{
    [sender resignFirstResponder];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld", (long)row];
}

#pragma mark - CSDatePickerDelegate

- (void)setDate:(NSDate *)date
{
    _date = date;
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

#pragma mark - CSCategoryPickerDelegate

- (void)setCategory:(NSString *)category
{
    _category = category;
    self.categoryLabel.text = category;
}

#pragma mark - CSLabelPickerDelegate

- (void)setLabel:(NSString *)label
{
    _label = label;
    self.labelLabel.text = label;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pickDateSegue"]) {
        CSDatePickerViewController *datePickerController = segue.destinationViewController;
        datePickerController.delegate = self;
        datePickerController.date = _date;
    } else if ([segue.identifier isEqualToString:@"pickCategorySegue"]){
        UINavigationController *navigationController = segue.destinationViewController;
        CSCategoryPickerTableViewController *categoryPickerController = (CSCategoryPickerTableViewController *)navigationController.topViewController;
        categoryPickerController.delegate = self;
        categoryPickerController.dataSource = [[CSLocalDataManager instance] categories];
        categoryPickerController.item = _category;
    } else if ([segue.identifier isEqualToString:@"pickLabelSegue"]){
        UINavigationController *navigationController = segue.destinationViewController;
        CSLabelPickerTableViewController *categoryPickerController = (CSLabelPickerTableViewController *)navigationController.topViewController;
        categoryPickerController.delegate = self;
        categoryPickerController.dataSource = [[CSLocalDataManager instance] labels];
        categoryPickerController.item = _label;
    }
}

@end
