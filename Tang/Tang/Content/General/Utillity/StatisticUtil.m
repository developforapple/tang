//
//  StatisticUtil.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2018/2/5.
//  Copyright © 2018年 来电科技. All rights reserved.
//

#import "StatisticUtil.h"

#if UMengSDK_Enabled
    #import <UMMobClick/MobClick.h>
#endif

#if LeanCloudSDK_Enabled
    #import <AVOSCloud/AVAnalytics.h>
#endif

@implementation StatisticUtil

+ (void)setLatitude:(double)lat longitude:(double)lon
{
#if UMengSDK_Enabled
    [MobClick setLatitude:lat longitude:lon];
#endif
    
#if LeanCloudSDK_Enabled
    [AVAnalytics setLatitude:lat longitude:lon];
#endif
}

+ (void)beginLogPage:(NSString *)pageName
{
#if UMengSDK_Enabled
    [MobClick beginLogPageView:pageName];
#endif
    
#if LeanCloudSDK_Enabled
    [AVAnalytics beginLogPageView:pageName];
#endif
}

+ (void)endLogPage:(NSString *)pageName
{
#if UMengSDK_Enabled
    [MobClick endLogPageView:pageName];
#endif
    
#if LeanCloudSDK_Enabled
    [AVAnalytics endLogPageView:pageName];
#endif
}

+ (void)event:(NSString *)eventId
{
#if UMengSDK_Enabled
    [MobClick event:eventId];
#endif
    
#if LeanCloudSDK_Enabled
    [AVAnalytics event:eventId];
#endif
}

+ (void)event:(NSString *)eventId label:(NSString *)label
{
    
#if UMengSDK_Enabled
    [MobClick event:eventId label:label];
#endif
    
#if LeanCloudSDK_Enabled
    [AVAnalytics event:eventId label:label];
#endif
}

@end
