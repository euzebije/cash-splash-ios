//
//  CSSettingsManager.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 26/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSettingsManager.h"

#define kDropboxAppKey      @"dropbox_app_key"
#define kDropboxAppSecret   @"dropbox_app_secret"

@implementation CSSettingsManager

#pragma mark - Singleton

+ (CSSettingsManager *)sharedManager
{
    static CSSettingsManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSSettingsManager alloc] init];
    });
    return instance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        _dropBoxAppKey = [settings objectForKey:kDropboxAppKey];
        _dropBoxAppSecret = [settings objectForKey:kDropboxAppSecret];
    }
    return self;
}

@end
