//
//  CSRepositoryFactory.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSRepositoryFactory.h"

#import "CSSpendingModelRepository.h"

@implementation CSRepositoryFactory

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - Public methods

- (CSSpendingModelRepository *)createSpendingModelRepository
{
    return [[CSSpendingModelRepository alloc] init];
}

@end
