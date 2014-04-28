//
//  CSSplitMenuTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 28/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSplitMenuTableViewController.h"

#import "CSCategoryDataSource.h"
#import "CSLabelDataSource.h"
#import "CSTablePickerViewController.h"

@implementation CSSplitMenuTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSegueWithIdentifier:@"paymentSegue" sender:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"categoriesSegue"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        CSTablePickerViewController *categoryPickerController = (CSTablePickerViewController *)navigationController.topViewController;
        categoryPickerController.dataSource = [[CSCategoryDataSource alloc] init];
        categoryPickerController.delegate = self;
        categoryPickerController.canAddItems = YES;
        categoryPickerController.disablePicking = YES;
    }
    else if ([segue.identifier isEqualToString:@"labelsSegue"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        CSTablePickerViewController *categoryPickerController = (CSTablePickerViewController *)navigationController.topViewController;
        categoryPickerController.dataSource = [[CSLabelDataSource alloc] init];
        categoryPickerController.delegate = self;
        categoryPickerController.canAddItems = YES;
        categoryPickerController.disablePicking = YES;
    }
}

#pragma mark - CSTablePickerDelegate

- (NSString *)tablePicker:(CSTablePickerViewController *)tablePicker displayForItem:(id)item
{
    return (NSString *)item;
}

- (void)tablePicker:(CSTablePickerViewController *)tablePicker didPickValue:(id)value
{
    return;
}

@end
