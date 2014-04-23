//
//  CSRepositoryFactory.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSSpendingModelRepository;

@interface CSRepositoryFactory : NSObject

- (instancetype)init;

- (CSSpendingModelRepository *)createSpendingModelRepository;

@end
