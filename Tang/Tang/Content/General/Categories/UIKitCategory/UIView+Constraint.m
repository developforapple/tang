//
//  UIView+Constraint.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2018/2/3.
//  Copyright © 2018年 来电科技. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

- (void)constraint:(NSString *)v
                  :(NSString *)h
                  :(NSDictionary<NSString *, NSNumber *> *)metrics
                  :(NSDictionary<NSString *, UIView *> *)views
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (v) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:v options:kNilOptions metrics:metrics views:views]];
    }
    if (h) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:h options:kNilOptions metrics:metrics views:views]];
    }
}

@end
