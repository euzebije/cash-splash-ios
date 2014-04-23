//
//  CSSpendingModel.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSpendingModel.h"

#define kKeyKey         @"Id"
#define kAmountKey      @"Amount"
#define kCategoryKey    @"Category"
#define kLabelKey       @"Label"
#define kTimestampKey   @"Timestamp"
#define kNoteKey        @"Note"

@implementation CSSpendingModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.key = [[NSUUID UUID] UUIDString];
    }
    return self;
}

@end
