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

@end
