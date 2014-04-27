//
//  CSDropboxManager.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Dropbox/Dropbox.h>

@interface CSDropboxManager : NSObject

+ (void)syncDatastore:(DBDatastore *)datastore;

@end
