//
//  CSSaveSpendingTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSaveSpendingTableViewController.h"
#import "CSDatePickerViewController.h"

@implementation CSSaveSpendingTableViewController
{
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
    return [NSString stringWithFormat:@"%d", row];
}

#pragma mark - CSDatePickerDelegate

- (void)setDate:(NSDate *)date
{
    _date = date;
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pickDateSegue"]) {
        CSDatePickerViewController *datePickerController = segue.destinationViewController;
        datePickerController.delegate = self;
        datePickerController.date = _date;
    }
}

@end
