//
//  CSTablePickerViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 05/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSTablePickerViewController.h"

@implementation CSTablePickerViewController
{
    UITableViewCell *_selectedCell;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.canAddItems) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.delegate tablePicker:self didPickValue:self.selected];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    id item = [self.dataSource objectAtIndex:indexPath.row];
    NSString *text = [self.delegate tablePicker:self displayForItem:item];
    cell.textLabel.text = text;
    if (self.selected == item) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _selectedCell = cell;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (_selectedCell == selectedCell) {
        return;
    }
    
    _selectedCell.accessoryType = UITableViewCellAccessoryNone;
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectedCell = selectedCell;
    
    self.selected = [self.dataSource objectAtIndex:indexPath.row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CSNewItemTableViewController *controller = segue.destinationViewController;
    controller.delegate = self;
}

#pragma mark - CSNewItemDelegate

- (void)saveItem:(id)item
{
    if (item != nil) {
        [self.dataSource addObject:item];
        NSInteger row = MAX(0, self.dataSource.count - 1);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
