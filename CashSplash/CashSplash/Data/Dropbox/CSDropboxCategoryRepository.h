//
//  CSDropboxCategoryRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSCategoryRepository.h"
#import <Dropbox/Dropbox.h>

@interface CSDropboxCategoryRepository : CSCategoryRepository

- (instancetype)initWithDatastore:(DBDatastore *)datastore;

@end
