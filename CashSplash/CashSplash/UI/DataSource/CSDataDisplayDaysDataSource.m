//
//  CSDataDisplayDaysDataSource.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/05/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDataDisplayDaysDataSource.h"

@interface CSDataDisplayDaysDataSource()

@property (nonatomic, strong) NSArray *data;

@end

@implementation CSDataDisplayDaysDataSource

#pragma mark - Public methods

- (NSString *)displayForValue:(int)value
{
    if (value == 1)
    {
        return @"1 Day";
    }
    else
    {
        return [NSString stringWithFormat:@"%d Days", value];
    }
}

#pragma mark - CSTablePickerDatasource

- (NSArray *)items
{
    if (self.data == nil)
    {
        self.data = @[@1, @3, @7, @14, @30, @60, @180];
    }
    
    return self.data;
}

- (NSInteger)count
{
    return [[self items] count];
}

- (BOOL)save:(id)item
{
    // Not used
    return YES;
}

- (BOOL)remove:(id)item
{
    // Not used
    return YES;
}

- (void)refresh
{
    // Not used
}

@end
