//
//  CSSQLiteRepositoryFactory.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSQLiteRepositoryFactory.h"
#import <sqlite3.h>

#import "CSSQLiteSpendingModelRepository.h"
#import "CSSQLiteCategoryRepository.h"
#import "CSSQLiteLabelRepository.h"

#define kDatabaseFile   @"db.sqlite3"

#define kQueryCreateSpendingModelTable  @"CREATE TABLE spending_model(key TEXT PRIMARY KEY ASC, amount REAL, category TEXT, label TEXT, timestamp NUMERIC, note TEXT)"
#define kQueryCreateCategoryTable       @"CREATE TABLE category(name TEXT PRIMARY KEY ASC)"
#define kQueryCreateLabelTable          @"CREATE TABLE label(name TEXT PRIMARY KEY ASC)"

@implementation CSSQLiteRepositoryFactory
{
    NSString *_databasePath;
    sqlite3 *_database;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _databasePath = [self databasePath];
        BOOL databaseExists = [[NSFileManager defaultManager] fileExistsAtPath:_databasePath];
        if (!databaseExists)
        {
            [self createAndOpenDatabase];
        }
        else
        {
            [self openDatabase];
        }
    }
    return self;
}

- (void)dealloc
{
    sqlite3_close(_database);
}

#pragma mark - Database init

- (NSString *)databasePath
{
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    if (paths.count > 0)
    {
        NSURL *documentsPath = [paths firstObject];
        NSURL *databasePath = [documentsPath URLByAppendingPathComponent:kDatabaseFile];
        return [databasePath path];
    }
    
    return nil;
}

- (BOOL)createAndOpenDatabase
{
    if (sqlite3_open([_databasePath UTF8String], &_database) != SQLITE_OK)
    {
        NSLog(@"Failed to open database.");
        return NO;
    }
    
    // Spending model table
    if (![self createTable:kQueryCreateSpendingModelTable])
    {
        NSLog(@"Failed to create the spending_model table.");
        return NO;
    }
    
    // Category table
    if (![self createTable:kQueryCreateCategoryTable])
    {
        NSLog(@"Failed to create the category table.");
        return NO;
    }
    
    // Label table
    if (![self createTable:kQueryCreateLabelTable])
    {
        NSLog(@"Failed to create the label table.");
        return NO;
    }
    
    return YES;
}

- (BOOL)openDatabase
{
    if (sqlite3_open([_databasePath UTF8String], &_database) != SQLITE_OK)
    {
        NSLog(@"Failed to open database!");
        return NO;
    }
    return YES;
}

- (BOOL)createTable:(NSString *)query
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        int result = sqlite3_step(statement);
        sqlite3_finalize(statement);
        
        return result == SQLITE_DONE;
    }
    return NO;
}

#pragma mark - Public methods

- (CSSpendingModelRepository *)createSpendingModelRepository
{
    return [[CSSQLiteSpendingModelRepository alloc] initWithDatabase:_database];
}

- (CSCategoryRepository *)createCategoryRepository
{
    return [[CSSQLiteCategoryRepository alloc] initWithDatabase:_database];
}

- (CSLabelRepository *)createLabelRepository
{
    return [[CSSQLiteLabelRepository alloc] initWithDatabase:_database];
}

@end
