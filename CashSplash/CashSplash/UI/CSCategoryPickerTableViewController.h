//
//  CSCategoryPickerTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSItemPickerBaseTableViewController.h"

@protocol CSCategoryPickerDelegate <NSObject>

- (void)setCategory:(NSString *)category;

@end

@interface CSCategoryPickerTableViewController : CSItemPickerBaseTableViewController <CSNewItemDelegate>

@property (nonatomic, weak) id<CSCategoryPickerDelegate> delegate;

- (IBAction)doneTapped:(id)sender;

@end
