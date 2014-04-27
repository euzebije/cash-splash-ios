//
//  CSDropboxManager.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSDropboxManager.h"

@implementation CSDropboxManager

+ (void)syncDatastore:(DBDatastore *)datastore
{
    if (datastore && datastore.status & DBDatastoreIncoming)
    {
        [datastore sync:nil];
    }
}

@end
