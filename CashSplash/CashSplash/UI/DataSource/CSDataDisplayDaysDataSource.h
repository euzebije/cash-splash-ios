//
//  CSDataDisplayDaysDataSource.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/05/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTablePickerViewController.h"

@interface CSDataDisplayDaysDataSource : NSObject <CSTablePickerDatasource>

- (NSString *)displayForValue:(int)value;

@end
