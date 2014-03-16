//
//  CSLabelPickerTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSItemPickerBaseTableViewController.h"

@protocol CSLabelPickerDelegate <NSObject>

- (void)setLabel:(NSString *)label;

@end

@interface CSLabelPickerTableViewController : CSItemPickerBaseTableViewController

@property (nonatomic, weak) id<CSLabelPickerDelegate> delegate;

- (IBAction)doneTapped:(id)sender;

@end
