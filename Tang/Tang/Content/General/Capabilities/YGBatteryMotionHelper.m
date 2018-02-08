//
//  YGBatteryMotionHelper.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/5/15.
//  Copyright © 2017年 来电科技 All rights reserved.
//

#import "YGBatteryMotionHelper.h"

NSNotificationName kYGBatteryMotionHelperNotification = @"YGBatteryMotionHelperNotification";

@interface YGBatteryMotionHelper ()
@property (assign, readwrite, nonatomic) float level;
@property (assign, readwrite, nonatomic) UIDeviceBatteryState state;
@property (assign, readwrite, nonatomic) BOOL lowPowerMode;
@property (assign, readwrite, nonatomic) NSUInteger counting;
@end

@implementation YGBatteryMotionHelper

+ (instancetype)helper
{
    static YGBatteryMotionHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [YGBatteryMotionHelper new];
        helper.state = UIDeviceBatteryStateUnknown;
        helper.level = -1;
        helper.counting = 0;
    });
    return helper;
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryLevelDidChanged:) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryStateDidChanged:) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    if (iOS9) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lowPowerModeDidChanged:) name:NSProcessInfoPowerStateDidChangeNotification object:nil];
    }
}

- (void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)markBegining
{
    @synchronized (self){
        _counting++;
        if (_counting == 1) {
            [self startMonitor];
        }
        [self updateInfo];
    }
}

- (void)markEnded
{
    @synchronized (self) {
        if (_counting > 0) {
            _counting--;
            if (_counting == 0) {
                [self endMonitor];
            }
        }
        [self updateInfo];
    }
}

- (void)startMonitor
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [self registerNotifications];
}

- (void)endMonitor
{
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    [self removeNotifications];
}

- (BOOL)monitoring
{
    return self.counting > 0;
}

- (void)batteryLevelDidChanged:( NSNotification *)noti
{
    if (!self.monitoring) return;
    [self updateInfo];
}

- (void)batteryStateDidChanged:( NSNotification *)noti
{
    if (!self.monitoring) return;
    [self updateInfo];
}

- (void)lowPowerModeDidChanged:( NSNotification *)noti
{
    if (!self.monitoring) return;
    [self updateInfo];
}

- (void)updateInfo
{
    self.level = [UIDevice currentDevice].batteryLevel;
    self.state = [UIDevice currentDevice].batteryState;
    if (iOS9) {
        self.lowPowerMode = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kYGBatteryMotionHelperNotification object:self];
}

@end
