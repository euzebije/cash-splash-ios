//
//  CSCategoryRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCategoryRepository : NSObject

- (instancetype)init;

- (NSArray *)getAll;

- (void)save:(NSString *)category;
- (void)remove:(NSString *)category;

@end
