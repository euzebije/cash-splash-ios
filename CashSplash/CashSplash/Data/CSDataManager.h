//
//  CSDataManager.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSRepositoryFactory;

@interface CSDataManager : NSObject

+ (CSDataManager *)sharedManager;

- (CSRepositoryFactory *)repositoryFactory;
- (void)reload;

@end
