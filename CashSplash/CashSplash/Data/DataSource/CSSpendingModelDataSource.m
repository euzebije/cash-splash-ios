//
//  CSSpendingModelDataSource.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSpendingModelDataSource.h"

#import "CSDataManager.h"
#import "CSRepositoryFactory.h"
#import "CSSpendingModelRepository.h"

#import "CSSpendingModel.h"

@implementation CSSpendingModelDataSource
{
    CSSpendingModelRepository *_repository;
    NSMutableArray *_items;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CSRepositoryFactory *factory = [[CSDataManager sharedManager] repositoryFactory];
        _repository = [factory createSpendingModelRepository];
        _items = [NSMutableArray arrayWithArray:[_repository getAll]];
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)items
{
    return _items;
}

- (NSInteger)count
{
    return [_items count];
}

- (BOOL)save:(id)item
{
    if (![item isKindOfClass:[CSSpendingModel class]])
    {
        NSLog(@"item %@ not of type CSSpendingModel", item);
        return NO;
    }
    
    CSSpendingModel *model = (CSSpendingModel *)item;
    if (![_items containsObject:model])
    {
        if ([_repository save:model])
        {
            [_items addObject:model];
            return YES;
        }
    }
    return NO;
}

- (BOOL)remove:(id)item
{
    if (![item isKindOfClass:[CSSpendingModel class]])
    {
        NSLog(@"item %@ not of type CSSpendingModel", item);
        return NO;
    }
    
    CSSpendingModel *model = (CSSpendingModel *)item;
    if ([_items containsObject:model])
    {
        if ([_repository remove:model.key])
        {
            [_items removeObject:model];
            return YES;
        }
    }
    return NO;
}

- (void)refresh
{
    _items = [NSMutableArray arrayWithArray:[_repository getAll]];
}

@end
