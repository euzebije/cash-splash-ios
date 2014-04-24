//
//  CSLabelRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSLabelRepository : NSObject

- (instancetype)init;

- (NSArray *)getAll;

- (BOOL)save:(NSString *)label;
- (BOOL)remove:(NSString *)label;

@end
