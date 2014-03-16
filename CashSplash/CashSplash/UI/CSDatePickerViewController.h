//
//  CSDatePickerViewController.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 15/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSDatePickerDelegate <NSObject>

- (void)setDate:(NSDate *)date;

@end

@interface CSDatePickerViewController : UIViewController

@property (nonatomic, weak) id<CSDatePickerDelegate> delegate;
@property (nonatomic, retain) NSDate *date;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)doneTapped:(id)sender;

@end
