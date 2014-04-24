//
//  CSSQLiteCategoryRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSCategoryRepository.h"
#import <sqlite3.h>

#define kQueryCreateCategoryTable       @"CREATE TABLE category(name TEXT PRIMARY KEY ASC)"

@interface CSSQLiteCategoryRepository : CSCategoryRepository

- (instancetype)initWithDatabase:(sqlite3 *)database;

@end
