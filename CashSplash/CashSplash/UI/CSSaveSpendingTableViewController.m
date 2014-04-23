//
//  CSSaveSpendingTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSaveSpendingTableViewController.h"

#define kCategoryIdentifier @"category"
#define kLabelIdentifier @"label"

@implementation CSSaveSpendingTableViewController
{
    NSString *_category;
    NSString *_label;
    NSDate *_date;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDate:[NSDate date]];
}

- (IBAction)editEnd:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)saveTapped:(id)sender
{

}

#pragma mark - CSTablePickerDelegate
- (NSString *)tablePicker:(CSTablePickerViewController *)tablePicker displayForItem:(id)item
{
    return (NSString *)item;
}

- (void)tablePicker:(CSTablePickerViewController *)tablePicker didPickValue:(id)value
{
    if ([tablePicker.identifier isEqualToString:kCategoryIdentifier])
    {
        _category = value;
        self.categoryLabel.text = _category;
    }
    else if ([tablePicker.identifier isEqualToString:kLabelIdentifier])
    {
        _label = value;
        self.labelLabel.text = _label;
    }
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
    [self.amountTextField resignFirstResponder];
    [self.noteTextField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"pickDateSegue"])
    {
        CSDatePickerViewController *datePickerController = segue.destinationViewController;
        datePickerController.delegate = self;
        datePickerController.date = _date;
    }
    else if ([segue.identifier isEqualToString:@"pickCategorySegue"])
    {
        CSTablePickerViewController *categoryPickerController = segue.destinationViewController;
        categoryPickerController.delegate = self;
        categoryPickerController.dataSource = [NSMutableArray array];
        categoryPickerController.selected = @"";
        categoryPickerController.identifier = kCategoryIdentifier;
        categoryPickerController.canAddItems = YES;
    }
    else if ([segue.identifier isEqualToString:@"pickLabelSegue"])
    {
        CSTablePickerViewController *labelPickerController = segue.destinationViewController;
        labelPickerController.delegate = self;
        labelPickerController.dataSource = [NSMutableArray array];
        labelPickerController.selected = @"";
        labelPickerController.identifier = kLabelIdentifier;
        labelPickerController.canAddItems = YES;
    }
}

@end
