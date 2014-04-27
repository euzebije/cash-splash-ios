//
//  CSDataSourceBase.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDataSourceBase.h"

#import "CSDataManager.h"

@implementation CSDataSourceBase

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:kNotificationStorageChanged object:[CSDataManager sharedManager]];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationStorageChanged object:[CSDataManager sharedManager]];
}

#pragma mark - Public methods

- (void)reload
{
    
}

@end
