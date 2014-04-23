//
//  CSCategoryRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSCategoryRepository.h"

@implementation CSCategoryRepository
{
    NSMutableArray *_storage;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _storage = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)getAll
{
    return _storage;
}

- (void)save:(NSString *)category
{
    [_storage addObject:category];
}

- (void)remove:(NSString *)category
{
    [_storage removeObject:category];
}

@end
