//
//  YGThirdPartyNavigate.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/7/3.
//  Copyright © 2017年 来电科技 All rights reserved.
//

@import Foundation;
@import CoreLocation;

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YGNavigateKind) {
    YGNavigateKindGaode,
    YGNavigateKindBaidu,
    YGNavigateKindApple,
};

@interface YGThirdPartyNavigate : NSObject

// 传入GCJ坐标系
+ (void)navigateTo:(CLLocationCoordinate2D)coordinate name:(NSString *)name view:(UIView *)view;
+ (void)navigateTo:(CLLocationCoordinate2D)coordinate name:(NSString *)name use:(YGNavigateKind)kind;

@end
