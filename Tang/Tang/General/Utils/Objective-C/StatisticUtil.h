//
//  StatisticUtil.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2018/2/5.
//  Copyright © tiny. All rights reserved.
//

@import Foundation;

@interface StatisticUtil : NSObject
+ (void)setLatitude:(double)lat longitude:(double)lon;
+ (void)beginLogPage:(NSString *)pageName;
+ (void)endLogPage:(NSString *)pageName;
+ (void)event:(NSString *)eventId;
+ (void)event:(NSString *)eventId label:(NSString *)label;
@end

// 记录页面的显示
#define YG_BEGIN_PAGE( name )   \
    [StatisticUtil beginLogPage: name]

// 记录页面的消失
#define YG_END_PAGE( name )     \
    [StatisticUtil endLogPage: name]

// 记录一次事件
#define YG_EVENT_A( eventId )               \
    [StatisticUtil event: YG_OBJC_LOWER_STR( eventId ) ]

// 记录一次事件，和一个标签
#define YG_EVENT_B( eventId, eventLabel )   \
    [StatisticUtil event: YG_OBJC_LOWER_STR( eventId ) \
                   label: YG_OBJC_LOWER_STR( eventLabel ) ]
