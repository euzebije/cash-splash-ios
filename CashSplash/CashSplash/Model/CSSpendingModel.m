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

static NSNumberFormatter *currencyFormatter;

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.key = [[NSUUID UUID] UUIDString];
    }
    return self;
}

#pragma mark - Public methods

- (NSString *)formattedAmount
{
    if (currencyFormatter == nil)
    {
        currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:self.amount]];
}

- (NSString *)formattedDescription
{
    BOOL hasCategory = [self.category length] > 0;
    BOOL hasLabel = [self.label length] > 0;
    
    if (hasCategory && hasLabel)
    {
        return [NSString stringWithFormat:@"%@, %@", self.category, self.label];
    }
    else if (hasCategory)
    {
        return self.category;
    }
    else if (hasLabel)
    {
        return self.label;
    }
    
    return nil;
}

@end
