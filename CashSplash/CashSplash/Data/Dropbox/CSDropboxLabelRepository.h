//
//  CSDropboxLabelRepository.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLabelRepository.h"
#import <Dropbox/Dropbox.h>

@interface CSDropboxLabelRepository : CSLabelRepository

- (instancetype)initWithDatastore:(DBDatastore *)datastore;

@end
