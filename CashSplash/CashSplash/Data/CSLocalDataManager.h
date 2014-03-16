//
//  CSLocalDataManager.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSLocalDataManager : NSObject

+ (CSLocalDataManager *)instance;

@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) NSMutableArray *spendings;

- (void)save;

@end
