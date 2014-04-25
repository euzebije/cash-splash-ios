//
//  CSSaveSpendingTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSaveSpendingTableViewController.h"

#import "CSCategoryDataSource.h"
#import "CSLabelDataSource.h"
#import "CSDataManager.h"
#import "CSRepositoryFactory.h"
#import "CSSpendingModelRepository.h"
#import "CSSpendingModel.h"

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
    
    _category = nil;
    _label = nil;
    [self setDate:[NSDate date]];
}

- (IBAction)editEnd:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)saveTapped:(id)sender
{
    [self.amountTextField resignFirstResponder];
    [self.noteTextField resignFirstResponder];
    
    double amount = [self.amountTextField.text doubleValue];
    NSString *note = self.noteTextField.text;
    
    CSSpendingModel *model = [[CSSpendingModel alloc] init];
    model.amount = amount;
    model.category = _category;
    model.label = _label;
    model.timestamp = _date;
    model.note = note;
    
    CSRepositoryFactory *factory = [[CSDataManager sharedManager] repositoryFactory];
    CSSpendingModelRepository *repository = [factory createSpendingModelRepository];
    
    if ([repository save:model])
    {
        self.amountTextField.text = @"";
        _category = nil;
        self.categoryLabel.text = @"";
        _label = nil;
        self.labelLabel.text = @"";
        [self setDate:[NSDate date]];
        self.noteTextField.text = @"";
    }
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
        categoryPickerController.dataSource = [[CSCategoryDataSource alloc] init];
        categoryPickerController.selected = @"";
        categoryPickerController.identifier = kCategoryIdentifier;
        categoryPickerController.canAddItems = YES;
    }
    else if ([segue.identifier isEqualToString:@"pickLabelSegue"])
    {
        CSTablePickerViewController *labelPickerController = segue.destinationViewController;
        labelPickerController.delegate = self;
        labelPickerController.dataSource = [[CSLabelDataSource alloc] init];
        labelPickerController.selected = @"";
        labelPickerController.identifier = kLabelIdentifier;
        labelPickerController.canAddItems = YES;
    }
}

@end
