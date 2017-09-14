//
//  BingoTextView.m
//
//  Created by bo wang on 2017/4/17.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#import "BingoTextView.h"

@implementation BingoTextView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UILabel *label = [self placeHolderLabel];
    CGFloat top = self.textContainerInset.top;
    
    label.frame = CGRectMake(8, top, CGRectGetWidth(self.frame)-2*8, CGRectGetHeight(label.frame));
}

- (UILabel *)placeHolderLabel
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            return (UILabel *)view;
        }
    }
    return nil;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self placeHolderLabel].textColor = self.placeholderColor;
    [self placeHolderLabel].frame = self.bounds;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self placeHolderLabel].textColor = placeholderColor;
    [self placeHolderLabel].frame = self.bounds;
}

@end
