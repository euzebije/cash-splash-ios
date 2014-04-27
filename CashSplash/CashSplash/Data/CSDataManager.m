//
//  CSDataManager.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDataManager.h"

#import "CSSettingsManager.h"
#import "CSSQLiteRepositoryFactory.h"
#import "CSDropboxRepositoryFactory.h"

@implementation CSDataManager
{
    CSRepositoryFactory *_repositoryFactory;
}

#pragma mark - Singleton

+ (CSDataManager *)sharedManager
{
    static CSDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSDataManager alloc] init];
    });
    return instance;
}

#pragma mark - Public methods

- (CSRepositoryFactory *)repositoryFactory
{
    if (_repositoryFactory == nil)
    {
        _repositoryFactory = [self createFactory];
    }
    return _repositoryFactory;
}

- (void)reload
{
    _repositoryFactory = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStorageChanged object:self userInfo:nil];
}

#pragma mark - Private methods

- (CSRepositoryFactory *)createFactory
{
    BOOL useDropbox = [[CSSettingsManager sharedManager] useDropbox];
    if (useDropbox)
    {
        return [[CSDropboxRepositoryFactory alloc] init];
    }
    
    return [[CSSQLiteRepositoryFactory alloc] init];
}

@end
