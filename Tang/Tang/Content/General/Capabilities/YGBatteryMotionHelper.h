//
//  YGBatteryMotionHelper.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/5/15.
//  Copyright © 2017年 来电科技 All rights reserved.
//

@import Foundation;

FOUNDATION_EXTERN NSNotificationName kYGBatteryMotionHelperNotification;

@interface YGBatteryMotionHelper : NSObject

+ (instancetype)helper;

@property (assign, readonly, nonatomic) float level;
@property (assign, readonly, nonatomic) UIDeviceBatteryState state;
// 9.0开始支持低电量模式
@property (assign, readonly, nonatomic) BOOL lowPowerMode;
@property (assign, readonly, nonatomic) NSUInteger counting;
- (BOOL)monitoring;

- (void)markBegining;
- (void)markEnded;

@end
