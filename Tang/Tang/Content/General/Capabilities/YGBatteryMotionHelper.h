//
//  YGBatteryMotionHelper.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/5/15.
//  Copyright © 2017年 来电科技 All rights reserved.
//

@import Foundation;

typedef void(^YGBatteryInfoChangedHandler)(float level, UIDeviceBatteryState state, BOOL lowPowerMode);

@interface YGBatteryMotionHelper : NSObject

+ (instancetype)helper;

@property (assign, readonly, nonatomic) BOOL monitoring;
@property (assign, readonly, nonatomic) float level;
@property (assign, readonly, nonatomic) UIDeviceBatteryState state;

// 9.0开始支持低电量模式
@property (assign, readonly, nonatomic) BOOL lowPowerMode;

- (void)startMonitor;
- (void)endMonitor;

- (void)setObserveHandler:(YGBatteryInfoChangedHandler)handler;

@end
