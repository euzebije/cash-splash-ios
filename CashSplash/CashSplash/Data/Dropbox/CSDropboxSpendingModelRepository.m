//
//  CSDropboxSpendingModelRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDropboxSpendingModelRepository.h"
#import "CSSpendingModel.h"

#define kTableName  @"spending_model"

@implementation CSDropboxSpendingModelRepository
{
    DBDatastore *_datastore;
    DBTable *_table;
}

#pragma mark - Init

- (instancetype)initWithDatastore:(DBDatastore *)datastore
{
    self = [super init];
    if (self)
    {
        _datastore = datastore;
        if (datastore)
        {
            _table = [_datastore getTable:kTableName];
        }
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)getAll
{
    if (_table)
    {
        DBError *error = nil;
        NSArray *data = [_table query:nil error:&error];
        
        if (error)
        {
            NSLog(@"[Dropbox] Spending model getAll error: %@", error);
            return nil;
        }
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[data count]];
        for (DBRecord *item in data)
        {
            [items addObject:[self modelFromDBRecord:item]];
        }
        
        return items;
    }
    return nil;
}

- (CSSpendingModel *)get:(NSString *)key
{
    if (_table)
    {
        DBError *error = nil;
        
        NSArray *records = [_table query:@{@"key": key} error:&error];
        if (error)
        {
            NSLog(@"[Dropbox] Spending model get error: %@", error);
            return NO;
        }
        
        DBRecord *record = [records firstObject];
        if (record)
        {
            return [self modelFromDBRecord:record];
        }
    }
    return nil;
}

- (BOOL)save:(CSSpendingModel *)model
{
    if (_table)
    {
        DBError *error = nil;
        [_table insert:[self dictionaryFromModel:model]];
        [_datastore sync:&error];
        
        if (error)
        {
            NSLog(@"[Dropbox] Spending model save error: %@", error);
            return NO;
        }
        return YES;
    }
    return NO;
}

- (BOOL)remove:(NSString *)key
{
    if (_table)
    {
        DBError *error = nil;
        
        NSArray *records = [_table query:@{@"key": key} error:&error];
        if (error)
        {
            NSLog(@"[Dropbox] Spending model remove error: %@", error);
            return NO;
        }
        
        error = nil;
        DBRecord *record = [records firstObject];
        if (record)
        {
            [record deleteRecord];
            [_datastore sync:&error];
            
            if (error)
            {
                NSLog(@"[Dropbox] Spending model remove error: %@", error);
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

#pragma mark - Private methods

- (CSSpendingModel *)modelFromDBRecord:(DBRecord *)dbRecord
{
    CSSpendingModel *model = [[CSSpendingModel alloc] init];
    model.key = dbRecord[@"key"];
    model.amount = [dbRecord[@"amount"] floatValue];
    model.category = dbRecord[@"category"];
    model.label = dbRecord[@"label"];
    model.timestamp = dbRecord[@"timestamp"];
    model.note = dbRecord[@"note"];
    
    return model;
}

- (NSDictionary *)dictionaryFromModel:(CSSpendingModel *)model
{
    return @{
             @"key": model.key,
             @"amount": [NSNumber numberWithFloat:model.amount],
             @"category": model.category,
             @"label": model.label,
             @"timestamp": model.timestamp,
             @"note": model.note
             };
}

@end
