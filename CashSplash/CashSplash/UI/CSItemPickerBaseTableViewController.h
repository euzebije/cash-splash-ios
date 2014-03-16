//
//  CSItemPickerBaseTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewItemTableViewController.h"

@interface CSItemPickerBaseTableViewController : UITableViewController <CSNewItemDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *item;

@property (nonatomic, strong) UITableViewCell *selectedCell;
@property (nonatomic, copy) NSString *cellReuseIdentifier;

@end
