//
//  CSDropboxRepositoryFactory.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDropboxRepositoryFactory.h"

#import <Dropbox/Dropbox.h>
#import "CSDropboxCategoryRepository.h"
#import "CSDropboxLabelRepository.h"
#import "CSDropboxSpendingModelRepository.h"

@implementation CSDropboxRepositoryFactory
{
    DBDatastore *_datastore;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        DBError *error = nil;
        DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
        _datastore = [DBDatastore openDefaultStoreForAccount:account error:&error];
        
        if (error)
        {
            _datastore = nil;
        }
    }
    return self;
}

#pragma mark - Public methods

- (CSCategoryRepository *)createCategoryRepository
{
    return [[CSDropboxCategoryRepository alloc] initWithDatastore:_datastore];
}

- (CSLabelRepository *)createLabelRepository
{
    return [[CSDropboxLabelRepository alloc] initWithDatastore:_datastore];
}

- (CSSpendingModelRepository *)createSpendingModelRepository
{
    return [[CSDropboxSpendingModelRepository alloc] initWithDatastore:_datastore];
}

@end
