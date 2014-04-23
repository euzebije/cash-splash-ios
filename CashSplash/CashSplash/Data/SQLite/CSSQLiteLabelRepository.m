//
//  CSSQLiteLabelRepository.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSQLiteLabelRepository.h"

@implementation CSSQLiteLabelRepository
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

@end
