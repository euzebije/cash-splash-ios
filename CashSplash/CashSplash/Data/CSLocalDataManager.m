//
//  CSLocalDataManager.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLocalDataManager.h"

@implementation CSLocalDataManager

#pragma mark - Singleton

+ (CSLocalDataManager *)instance
{
    static CSLocalDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSLocalDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.categories = [NSMutableArray arrayWithObjects:@"Category 1", @"Category 2", @"Category 3", nil];
        self.labels = [NSMutableArray arrayWithObjects:@"Label 1", @"Label 2", @"Label 3", nil];
    }
    return self;
}

#pragma mark - Public methods

@end
