//
//  CSNewItemTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSNewItemTableViewController.h"

@implementation CSNewItemTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.itemTextField becomeFirstResponder];
}

- (IBAction)saveTapped:(id)sender
{
    if (self.delegate != nil) {
        [self.delegate saveItem:self.itemTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
