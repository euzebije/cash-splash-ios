//
//  CSSpendingModel.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSpendingModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSDate *timestamp;
@property (nonatomic, copy) NSString *note;

- (instancetype)init;
- (instancetype)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
