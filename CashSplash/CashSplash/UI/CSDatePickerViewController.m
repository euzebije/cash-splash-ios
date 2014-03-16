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

- (IBAction)doneTapped:(id)sender
{
    if (self.delegate != nil) {
        [self.delegate setDate:self.datePicker.date];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
