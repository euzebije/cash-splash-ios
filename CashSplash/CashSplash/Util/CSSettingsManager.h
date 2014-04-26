//
//  CSSettingsManager.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSettingsManager : NSObject

+ (CSSettingsManager *)sharedManager;

- (instancetype)init;

@property (nonatomic, readonly) NSString *dropBoxAppKey;
@property (nonatomic, readonly) NSString *dropBoxAppSecret;

@end
