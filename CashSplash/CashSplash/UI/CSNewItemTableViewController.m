//
//  CSNewItemTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSNewItemTableViewController.h"

@implementation CSNewItemTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.navigationTitle;
    self.itemTextField.placeholder = self.textFieldPlaceholder;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.itemTextField becomeFirstResponder];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionTitle;
}

- (IBAction)saveTapped:(id)sender
{
    if (self.delegate != nil) {
        [self.delegate saveItem:self.itemTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
