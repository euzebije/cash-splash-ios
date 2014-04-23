//
//  CSSQLiteLabelRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 23/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLabelRepository.h"
#import <sqlite3.h>

@interface CSSQLiteLabelRepository : CSLabelRepository

- (instancetype)initWithDatabase:(sqlite3 *)database;

@end
