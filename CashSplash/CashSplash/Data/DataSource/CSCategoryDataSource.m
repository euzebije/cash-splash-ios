//
//  CSCategoryDataSource.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 24/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSCategoryDataSource.h"

#import "CSDataManager.h"
#import "CSRepositoryFactory.h"
#import "CSCategoryRepository.h"

@implementation CSCategoryDataSource
{
    CSCategoryRepository *_repository;
    NSMutableArray *_items;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self reload];
    }
    return self;
}

- (void)reload
{
    CSRepositoryFactory *factory = [[CSDataManager sharedManager] repositoryFactory];
    _repository = [factory createCategoryRepository];
    _items = [NSMutableArray arrayWithArray:[_repository getAll]];
}

#pragma mark - CSTablePickerDatasource

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
    NSString *category = (NSString *)item;
    if (![_items containsObject:category])
    {
        if ([_repository save:category])
        {
            [_items addObject:category];
            return YES;
        }
    }
    return NO;
}

- (BOOL)remove:(id)item
{
    NSString *category = (NSString *)item;
    if ([_items containsObject:category])
    {
        if ([_repository remove:category])
        {
            [_items removeObject:category];
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
