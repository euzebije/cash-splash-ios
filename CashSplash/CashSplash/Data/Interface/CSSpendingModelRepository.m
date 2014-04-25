//
//  CSSpendingModelRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSpendingModelRepository.h"
#import "CSSpendingModel.h"

@implementation CSSpendingModelRepository
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
    return [NSArray arrayWithArray:_storage];
}

- (CSSpendingModel *)get:(NSString *)key
{
    for (CSSpendingModel *model in _storage)
    {
        if ([model.key isEqualToString:key])
        {
            return model;
        }
    }
    return nil;
}

- (BOOL)save:(CSSpendingModel *)model
{
    [_storage addObject:model];
    return YES;
}

- (BOOL)remove:(NSString *)key
{
    [_storage removeObject:[self get:key]];
    return YES;
}

@end
