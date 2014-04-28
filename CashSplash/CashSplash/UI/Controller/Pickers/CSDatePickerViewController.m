//
//  CSDatePickerViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDatePickerViewController.h"

@implementation CSDatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datePicker.date = self.date;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.delegate != nil)
    {
        [self.delegate setDate:self.datePicker.date];
    }
}

- (CGSize)preferredContentSize
{
    return CGSizeMake(480, 216);
}

@end
