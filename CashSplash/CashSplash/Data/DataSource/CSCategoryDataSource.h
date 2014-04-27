//
//  CSCategoryDataSource.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 24/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSDataSourceBase.h"
#import "CSTablePickerViewController.h"

@interface CSCategoryDataSource : CSDataSourceBase <CSTablePickerDatasource>

- (instancetype)init;

@end
