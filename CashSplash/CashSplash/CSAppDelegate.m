//
//  CSAppDelegate.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSAppDelegate.h"

#import <Dropbox/Dropbox.h>
#import "CSSettingsManager.h"
#import "CSDataManager.h"

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CSSettingsManager *settings = [CSSettingsManager sharedManager];
    DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:settings.dropBoxAppKey secret:settings.dropBoxAppSecret];
    [DBAccountManager setSharedManager:accountManager];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account)
    {
        NSLog(@"Dropbox successfully enabled");
        CSSettingsManager *settings = [CSSettingsManager sharedManager];
        settings.useDropbox = YES;
        [settings sync];
        [[CSDataManager sharedManager] reload];
        
        return YES;
    }
    return NO;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[DBAccountManager sharedManager] removeObserver:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount *account) {
        CSSettingsManager *settings = [CSSettingsManager sharedManager];
        if (settings.useDropbox && !account.linked)
        {
            settings.useDropbox = NO;
            [settings sync];
            [[CSDataManager sharedManager] reload];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Dropbox" message:@"Cash splash was unlinked from Dropbox. Switched to local storage." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

@end
