//
//  CSDataDetailsTableViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDataDetailsTableViewController.h"

#import "CSSpendingModel.h"

@implementation CSDataDetailsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.amountLabel.text = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:self.model.amount]];
    self.categoryLabel.text = self.model.category;
    self.labelLabel.text = self.model.label;
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:self.model.timestamp dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    self.noteLabel.text = self.model.note;
}

@end
