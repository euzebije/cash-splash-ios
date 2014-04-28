//
//  CSSplitViewController.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 28/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSSplitViewController.h"

@implementation CSSplitViewController

- (void)viewDidLoad
{
    self.delegate = self;
    
    [super viewDidLoad];
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

@end
