//
//  CSDropboxLabelRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDropboxLabelRepository.h"

#define kTableName  @"label"

@implementation CSDropboxLabelRepository
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
            NSLog(@"[Dropbox] Label getAll error: %@", error);
            return nil;
        }
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[data count]];
        for (DBRecord *item in data)
        {
            [items addObject:item[@"name"]];
        }
        
        return items;
    }
    return nil;
}

- (BOOL)save:(NSString *)label
{
    if (_table)
    {
        DBError *error = nil;
        [_table insert:@{@"name": label}];
        [_datastore sync:&error];
        
        if (error)
        {
            NSLog(@"[Dropbox] Label save error: %@", error);
            return NO;
        }
        return YES;
    }
    return NO;
}

- (BOOL)remove:(NSString *)label
{
    if (_table)
    {
        DBError *error = nil;
        
        NSArray *records = [_table query:@{@"name": label} error:&error];
        if (error)
        {
            NSLog(@"[Dropbox] Category remove error: %@", error);
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
                NSLog(@"[Dropbox] Category remove error: %@", error);
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

@end
