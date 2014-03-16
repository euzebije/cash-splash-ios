//
//  CSLabelPickerTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLabelPickerTableViewController.h"

@implementation CSLabelPickerTableViewController

- (void)loadView
{
    self.cellReuseIdentifier = @"labelCell";
    [super loadView];
}

- (void)doneTapped:(id)sender
{
    if (self.delegate != nil && self.selectedCell != nil) {
        [self.delegate setLabel:self.selectedCell.textLabel.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CSNewItemTableViewController *controller = segue.destinationViewController;
    controller.delegate = self;
    controller.navigationTitle = @"Label";
    controller.sectionTitle = @"New Label";
    controller.textFieldPlaceholder = @"Enter new label name here";
}

@end
