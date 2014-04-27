//
//  CSDropboxSpendingModelRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSpendingModelRepository.h"
#import <Dropbox/Dropbox.h>

@interface CSDropboxSpendingModelRepository : CSSpendingModelRepository

- (instancetype)initWithDatastore:(DBDatastore *)datastore;

@end
