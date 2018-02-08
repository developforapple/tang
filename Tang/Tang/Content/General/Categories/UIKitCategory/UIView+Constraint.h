//
//  UIView+Constraint.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2018/2/3.
//  Copyright © 2018年 来电科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraint)

- (void)constraint:(NSString *)v
                  :(NSString *)h
                  :(NSDictionary<NSString *, NSNumber *> *)metrics
                  :(NSDictionary<NSString *, UIView *> *)views;

@end
