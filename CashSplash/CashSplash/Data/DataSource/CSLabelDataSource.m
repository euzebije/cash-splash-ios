//
//  CSLabelDataSource.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 24/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLabelDataSource.h"

#import "CSDataManager.h"
#import "CSRepositoryFactory.h"
#import "CSLabelRepository.h"

@implementation CSLabelDataSource
{
    CSLabelRepository *_repository;
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
    _repository = [factory createLabelRepository];
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
    NSString *label = (NSString *)item;
    if (![_items containsObject:label])
    {
        if ([_repository save:label])
        {
            [_items addObject:label];
            return YES;
        }
    }
    return NO;
}

- (BOOL)remove:(id)item
{
    NSString *label = (NSString *)item;
    if ([_items containsObject:label])
    {
        if ([_repository remove:label])
        {
            [_items removeObject:label];
            return YES;
        }
    }
    return NO;
}

@end
