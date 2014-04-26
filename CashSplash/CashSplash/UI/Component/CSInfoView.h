//
//  CSInfoView.h
//  CashSplash
//
//  Created by Ivan Fabijanovic on 25/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSInfoView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

+ (void)animateWithDuration:(NSTimeInterval)duration fadeDuration:(NSTimeInterval)fadeDuration text:(NSString *)text containerView:(UIView *)containerView;

@property (nonatomic, copy) NSString *text;

@end
