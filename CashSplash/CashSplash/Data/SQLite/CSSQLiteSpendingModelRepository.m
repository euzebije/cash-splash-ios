//
//  CSSQLiteSpendingModelRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSQLiteSpendingModelRepository.h"
#import "CSSpendingModel.h"

#define kQueryGetAll            @"SELECT key, amount, category, label, timestamp, note FROM spending_model"
#define kQueryGetAllDateFilter  @"SELECT key, amount, category, label, timestamp, note FROM spending_model WHERE timestamp >= ?"
#define kQueryGet               @"SELECT key, amount, category, label, timestamp, note FROM spending_model WHERE key = ?"
#define kQuerySave              @"INSERT INTO spending_model (key, amount, category, label, timestamp, note) VALUES (?, ?, ?, ?, ?, ?)"
#define kQueryRemove            @"DELETE FROM spending_model WHERE key = ?"

@implementation CSSQLiteSpendingModelRepository
{
    sqlite3 *_database;
}

#pragma mark - Init

- (instancetype)initWithDatabase:(sqlite3 *)database
{
    self = [super init];
    if (self)
    {
        _database = database;
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)getAll
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQueryGetAll UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            [items addObject:[self modelFromStatement:statement]];
        }
        sqlite3_finalize(statement);
    }
    return items;
}

- (NSArray *)getAllFromDate:(NSDate *)date
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQueryGetAllDateFilter UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_int(statement, 1, (int)floor([date timeIntervalSince1970]));
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            [items addObject:[self modelFromStatement:statement]];
        }
        sqlite3_finalize(statement);
    }
    return items;
}

- (CSSpendingModel *)get:(NSString *)key
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQueryGet UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [key UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
            return [self modelFromStatement:statement];
        }
    }
    return nil;
}

- (BOOL)save:(CSSpendingModel *)model
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQuerySave UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [model.key UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_double(statement, 2, model.amount);
        sqlite3_bind_text(statement, 3, [model.category UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [model.label UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 5, (int)[model.timestamp timeIntervalSince1970]);
        sqlite3_bind_text(statement, 6, [model.note UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
            return YES;
        }
    }
    return NO;
}

- (BOOL)remove:(NSString *)key
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQueryRemove UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [key UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
            return YES;
        }
    }
    return NO;
}

#pragma mark - Private methods

- (CSSpendingModel *)modelFromStatement:(sqlite3_stmt *)statement
{
    char *keyChars = (char *)sqlite3_column_text(statement, 0);
    double amount = sqlite3_column_double(statement, 1);
    char *categoryChars = (char *)sqlite3_column_text(statement, 2);
    char *labelChars = (char *)sqlite3_column_text(statement, 3);
    int timestamp = sqlite3_column_int(statement, 4);
    char *noteChars = (char *)sqlite3_column_text(statement, 5);
    
    CSSpendingModel *model = [[CSSpendingModel alloc] init];
    model.key = [NSString stringWithUTF8String:keyChars];
    model.amount = amount;
    model.category = [NSString stringWithUTF8String:categoryChars];
    model.label = [NSString stringWithUTF8String:labelChars];
    model.timestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    model.note = [NSString stringWithUTF8String:noteChars];
    
    return model;
}

@end
