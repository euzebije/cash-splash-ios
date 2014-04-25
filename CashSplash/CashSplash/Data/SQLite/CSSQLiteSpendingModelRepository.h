//
//  CSSQLiteSpendingModelRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSpendingModelRepository.h"
#import <sqlite3.h>

#define kQueryCreateSpendingModelTable  @"CREATE TABLE spending_model(key TEXT PRIMARY KEY ASC, amount REAL, category TEXT, label TEXT, timestamp INTEGER, note TEXT)"

@interface CSSQLiteSpendingModelRepository : CSSpendingModelRepository

- (instancetype)initWithDatabase:(sqlite3 *)database;

@end
