//
//  CSNewItemTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSNewItemTableViewController.h"

@implementation CSNewItemTableViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.itemTextField becomeFirstResponder];
}

- (CGSize)preferredContentSize
{
    return CGSizeMake(320, 173);
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self save];
        [self.popover dismissPopoverAnimated:YES];
    }
}

#pragma mark - Actions

- (IBAction)saveTapped:(id)sender
{
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save
{
    if (self.delegate != nil)
    {
        [self.delegate saveItem:self.itemTextField.text];
    }
}

@end
