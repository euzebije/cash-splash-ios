//
//  CSSpendingModel.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSpendingModel.h"

#define kIdKey          @"Id"
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
        self.id = [[NSUUID UUID] UUIDString];
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.id = [decoder decodeObjectForKey:kIdKey];
        self.amount = [decoder decodeFloatForKey:kAmountKey];
        self.category = [decoder decodeObjectForKey:kCategoryKey];
        self.label = [decoder decodeObjectForKey:kLabelKey];
        self.timestamp = [decoder decodeObjectForKey:kTimestampKey];
        self.note = [decoder decodeObjectForKey:kNoteKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.id forKey:kIdKey];
    [encoder encodeFloat:self.amount forKey:kAmountKey];
    [encoder encodeObject:self.category forKey:kCategoryKey];
    [encoder encodeObject:self.label forKey:kLabelKey];
    [encoder encodeObject:self.timestamp forKey:kTimestampKey];
    [encoder encodeObject:self.note forKey:kNoteKey];
}

@end
