//
//  CSDropboxRepositoryFactory.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDropboxRepositoryFactory.h"

#import <Dropbox/Dropbox.h>
#import "CSSettingsManager.h"

@implementation CSDropboxRepositoryFactory

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CSSettingsManager *settings = [CSSettingsManager sharedManager];
        DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:settings.dropBoxAppKey secret:settings.dropBoxAppSecret];
        [DBAccountManager setSharedManager:accountManager];
    }
    return self;
}

#pragma mark - Public methods

@end
