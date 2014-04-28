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
    
    if (!self.canAddItems)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.delegate respondsToSelector:@selector(tablePicker:didPickValue:)])
    {
        [self.delegate tablePicker:self didPickValue:self.selected];
    }
}

- (void)refresh
{
    [_dataSource refresh];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    id item = [[self.dataSource items] objectAtIndex:indexPath.row];
    NSString *text = [self.delegate tablePicker:self displayForItem:item];
    cell.textLabel.text = text;
    
    if (self.selected == item || [self.selected isEqualToString:item])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _selectedCell = cell;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (self.disablePicking)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        id item = [[self.dataSource items] objectAtIndex:indexPath.row];
        if ([self.dataSource remove:item])
        {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.disablePicking)
    {
        return;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (_selectedCell == selectedCell)
    {
        return;
    }
    
    _selectedCell.accessoryType = UITableViewCellAccessoryNone;
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectedCell = selectedCell;
    
    self.selected = [[self.dataSource items] objectAtIndex:indexPath.row];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CSNewItemTableViewController *controller = segue.destinationViewController;
    controller.delegate = self;
    
    if ([segue.identifier isEqualToString:@"newItemPopoverSegue"])
    {
        controller.popover = [(UIStoryboardPopoverSegue *)segue popoverController];
    }
}

#pragma mark - CSNewItemDelegate

- (void)saveItem:(id)item
{
    if (item != nil)
    {
        if ([self.dataSource save:item])
        {
            NSInteger row = MAX(0, self.dataSource.count - 1);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

@end
