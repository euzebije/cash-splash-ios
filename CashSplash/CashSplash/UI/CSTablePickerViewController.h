//
//  CSTablePickerViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 05/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewItemTableViewController.h"

@class CSTablePickerViewController;

@protocol CSTablePickerDatasource <NSObject>

- (NSArray *)items;
- (NSInteger)count;
- (BOOL)save:(id)item;
- (BOOL)remove:(id)item;

@end

@protocol CSTablePickerDelegate <NSObject>

- (void)tablePicker:(CSTablePickerViewController *)tablePicker didPickValue:(id)value;
- (NSString *)tablePicker:(CSTablePickerViewController *)tablePicker displayForItem:(id)item;

@end

@interface CSTablePickerViewController : UITableViewController <CSNewItemDelegate>

@property (nonatomic, assign) id selected;
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, assign) BOOL canAddItems;

@property (nonatomic, retain) id<CSTablePickerDatasource> dataSource;
@property (nonatomic, assign) id<CSTablePickerDelegate> delegate;

@end
