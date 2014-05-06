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

#import "CSTablePickerViewController.h"
#import "CSDataDisplayDaysDataSource.h"

#define kDataDaysPickerIdentifier   @"DataDaysPicker"

@implementation CSSettingsTableViewController
{
    CSDataDisplayDaysDataSource *dataDaysDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CSSettingsManager *settings = [CSSettingsManager sharedManager];
    [self.useDropboxSwitch setOn:settings.useDropbox];
    
    [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount *account) {
        [self.useDropboxSwitch setOn:account.linked];
        [self.tableView reloadData];
    }];
    
    dataDaysDataSource = [[CSDataDisplayDaysDataSource alloc] init];
    self.dataDisplayDaysLabel.text = [dataDaysDataSource displayForValue:settings.dataDisplayDays];
    
    self.versionLabel.text = settings.appVersion;
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
            [self.useDropboxSwitch setOn:NO];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"dataDisplayLastSegue"])
    {
        CSTablePickerViewController *pickerController = segue.destinationViewController;
        pickerController.delegate = self;
        pickerController.dataSource = dataDaysDataSource;
        pickerController.selected = [NSNumber numberWithInt:[CSSettingsManager sharedManager].dataDisplayDays];
        pickerController.identifier = kDataDaysPickerIdentifier;
        pickerController.canAddItems = NO;
        pickerController.canDeselect = NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CSTablePickerDelegate

- (void)tablePicker:(CSTablePickerViewController *)tablePicker didPickValue:(id)value
{
    int intValue = [value intValue];
    self.dataDisplayDaysLabel.text = [dataDaysDataSource displayForValue:intValue];
    
    CSSettingsManager *settings = [CSSettingsManager sharedManager];
    settings.dataDisplayDays = intValue;
    [settings sync];
}

- (NSString *)tablePicker:(CSTablePickerViewController *)tablePicker displayForItem:(id)item
{
    return [dataDaysDataSource displayForValue:[item intValue]];
}

@end
