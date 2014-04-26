//
//  CSSQLiteCategoryRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSQLiteCategoryRepository.h"

#define kQueryGetAll    @"SELECT name FROM category"
#define kQuerySave      @"INSERT INTO category (name) VALUES (?)"
#define kQueryRemove    @"DELETE FROM category WHERE name = ?"

@implementation CSSQLiteCategoryRepository
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
            char *nameChars = (char *) sqlite3_column_text(statement, 0);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            
            [items addObject:name];
        }
        sqlite3_finalize(statement);
    }
    return items;
}

- (BOOL)save:(NSString *)category
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQuerySave UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [category UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
            return YES;
        }
    }
    return NO;
}

- (BOOL)remove:(NSString *)category
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [kQueryRemove UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(statement, 1, [category UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
            return YES;
        }
    }
    return NO;
}

@end
