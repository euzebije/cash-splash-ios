//
//  CSItemPickerBaseTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSItemPickerBaseTableViewController.h"

@implementation CSItemPickerBaseTableViewController

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    
    NSString *text = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    if ([text isEqualToString:self.item]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _selectedCell = cell;
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
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedCell isEqual:_selectedCell]) {
        return;
    }
    
    [_selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    [_selectedCell setSelected:NO animated:YES];
    
    [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [selectedCell setSelected:NO animated:YES];
    _selectedCell = selectedCell;
}

#pragma mark - CSNewItemDelegate

- (void)saveItem:(NSString *)item
{
    if (item != nil && item.length > 0) {
        [self.dataSource addObject:item];
        [[CSLocalDataManager instance] save];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
