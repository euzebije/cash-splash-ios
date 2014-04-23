//
//  CSLabelRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLabelRepository.h"

@implementation CSLabelRepository
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

- (void)save:(NSString *)label
{
    [_storage addObject:label];
}

- (void)remove:(NSString *)label
{
    [_storage removeObject:label];
}

@end
