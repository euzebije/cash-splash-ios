//
//  CSLocalDataManager.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 16/03/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSLocalDataManager.h"

#define kDataFolder     @"Data"
#define kDataFile       @"data.plist"
#define kCategoriesKey  @"Categories"
#define kLabelsKey      @"Labels"
#define kSpendingsKey   @"Spendings"

@implementation CSLocalDataManager
{
    NSString *_dataFolderPath;
    NSString *_dataFilePath;
}

#pragma mark - Singleton

+ (CSLocalDataManager *)instance
{
    static CSLocalDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSLocalDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        BOOL success = [self setupDataFolder];
        if (success) {
            success = [self loadLocalData];
            if (!success) {
                self.categories = [[NSMutableArray alloc] init];
                self.labels = [[NSMutableArray alloc] init];
                self.spendings = [[NSMutableArray alloc] init];
            }
        }
    }
    return self;
}

#pragma mark - Public methods

- (void)save
{
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.categories forKey:kCategoriesKey];
    [archiver encodeObject:self.labels forKey:kLabelsKey];
    [archiver encodeObject:self.spendings forKey:kSpendingsKey];
    [archiver finishEncoding];
    
    [data writeToFile:_dataFilePath atomically:YES];
}

#pragma mark - Private methods

- (BOOL)setupDataFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths firstObject];
    
    _dataFolderPath = [libraryPath stringByAppendingPathComponent:kDataFolder];
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_dataFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error setting up the data folder, %@", [error localizedDescription]);
    }
    
    return success;
}

- (BOOL)loadLocalData
{
    _dataFilePath = [_dataFolderPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:_dataFilePath];
    if (codedData == nil) {
        return NO;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    self.categories = [unarchiver decodeObjectForKey:kCategoriesKey];
    self.labels = [unarchiver decodeObjectForKey:kLabelsKey];
    self.spendings = [unarchiver decodeObjectForKey:kSpendingsKey];
    [unarchiver finishDecoding];
    
    return YES;
}

@end
