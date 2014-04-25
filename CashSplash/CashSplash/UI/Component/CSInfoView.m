//
//  CSInfoView.m
//  CashSplash
//
//  Created by Ivan Fabijanovic on 25/04/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

#import "CSInfoView.h"

#define kDefaultWidth   100
#define kDefaultHeight  75

@implementation CSInfoView
{
    UILabel *textLabel;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 10.0;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    textLabel.text = self.text;
}

#pragma mark - Public methods

+ (void)animateWithDuration:(NSTimeInterval)duration fadeDuration:(NSTimeInterval)fadeDuration text:(NSString *)text containerView:(UIView *)containerView
{
    CGSize viewSize = containerView.frame.size;
    CGPoint offset = CGPointZero;
    if ([containerView isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView *)containerView;
        offset = scrollView.contentOffset;
    }
    // Centered in container view with default width/height
    CGRect frame = CGRectMake((viewSize.width - kDefaultWidth) / 2.0f + offset.x,
                              (viewSize.height - kDefaultHeight) / 2.0f + offset.y,
                              kDefaultWidth, kDefaultHeight);
    
    CSInfoView *infoView = [[CSInfoView alloc] initWithFrame:frame];
    infoView.text = text;
    infoView.alpha = 0;
    [containerView addSubview:infoView];
    
    [UIView animateWithDuration:fadeDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        infoView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:fadeDuration delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
            infoView.alpha = 0;
        } completion:^(BOOL finished) {
            [infoView removeFromSuperview];
        }];
    }];
}

@end
