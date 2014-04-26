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
    char *error;
    if (sqlite3_exec(_database, [query UTF8String], NULL, NULL, &error) != SQLITE_OK)
    {
        NSLog(@"Error: %@", [NSString stringWithUTF8String:error]);
        sqlite3_close(_database);
        return NO;
    }
    return YES;
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
