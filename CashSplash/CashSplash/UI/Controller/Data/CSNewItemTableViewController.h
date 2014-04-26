//
//  CSNewItemTableViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSNewItemDelegate <NSObject>

- (void)saveItem:(id)item;

@end

@interface CSNewItemTableViewController : UITableViewController

@property (nonatomic, weak) id<CSNewItemDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *itemTextField;

- (IBAction)saveTapped:(id)sender;

@end
