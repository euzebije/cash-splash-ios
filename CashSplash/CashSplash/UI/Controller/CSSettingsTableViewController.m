//
//  CSSettingsTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSettingsTableViewController.h"

#import <Dropbox/Dropbox.h>
#import "CSSettingsManager.h"
#import "CSDataManager.h"

@implementation CSSettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CSSettingsManager *settings = [CSSettingsManager sharedManager];
    [self.useDropboxSwitch setOn:settings.useDropbox];
    
    [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount *account) {
        [self.useDropboxSwitch setOn:account.linked];
        [self.tableView reloadData];
    }];
}

#pragma mark - Dropbox

- (IBAction)useDropboxChanged:(id)sender
{
    CSSettingsManager *settings = [CSSettingsManager sharedManager];
    DBAccountManager *manager = [DBAccountManager sharedManager];
    
    if (self.useDropboxSwitch.isOn)
    {
        DBAccount *account = [manager linkedAccount];
        if (account)
        {
            NSLog(@"Dropbox already linked");
            settings.useDropbox = YES;
            [settings sync];
            [self.tableView reloadData];
            [[CSDataManager sharedManager] reload];
        }
        else
        {
            [manager linkFromController:self];
        }
    }
    else
    {
        settings.useDropbox = NO;
        [settings sync];
        [self.tableView reloadData];
        [[CSDataManager sharedManager] reload];
    }
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        // Storage section
        if (self.useDropboxSwitch.isOn)
        {
            return @"Using Dropbox";
        }
        else
        {
            return @"Using local storage";
        }
    }
    
    return nil;
}

@end
