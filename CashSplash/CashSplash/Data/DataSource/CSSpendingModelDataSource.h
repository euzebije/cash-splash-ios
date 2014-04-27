//
//  CSSpendingModelDataSource.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSDataSourceBase.h"

@interface CSSpendingModelDataSource : CSDataSourceBase

- (instancetype)init;

- (NSArray *)items;
- (NSInteger)count;
- (BOOL)save:(id)item;
- (BOOL)remove:(id)item;

- (void)refresh;

@end
