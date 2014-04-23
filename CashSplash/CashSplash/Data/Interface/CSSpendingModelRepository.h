//
//  CSSpendingModelRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSSpendingModel;

@interface CSSpendingModelRepository : NSObject

- (instancetype)init;

- (NSArray *)getAll;
- (CSSpendingModel *)get:(NSString *)key;

- (void)save:(CSSpendingModel *)model;
- (void)remove:(NSString *)key;

@end
