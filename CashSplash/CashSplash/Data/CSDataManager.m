//
//  CSDataManager.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDataManager.h"

#import "CSSQLiteRepositoryFactory.h"

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
        _repositoryFactory = [[CSSQLiteRepositoryFactory alloc] init];
    }
    return _repositoryFactory;
}

@end
