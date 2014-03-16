//
//  CSCategoryPickerTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSCategoryPickerTableViewController.h"

@implementation CSCategoryPickerTableViewController

- (void)loadView
{
    self.cellReuseIdentifier = @"categoryCell";
    [super loadView];
}

- (IBAction)doneTapped:(id)sender
{
    if (self.delegate != nil && self.selectedCell != nil) {
        [self.delegate setCategory:self.selectedCell.textLabel.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CSNewItemTableViewController *controller = segue.destinationViewController;
    controller.delegate = self;
    controller.navigationTitle = @"Category";
    controller.sectionTitle = @"New Category";
    controller.textFieldPlaceholder = @"Enter new category name here";
}

#pragma mark - CSNewItemDelegate

- (void)saveItem:(NSString *)item
{
    if (item != nil && item.length > 0) {
        [self.dataSource addObject:item];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
