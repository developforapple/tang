//
//  CDTAlertAction.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/5/12.
//  Copyright © 2017年 来电科技 All rights reserved.
//

@import Foundation;

@interface CDTAlertAction : NSObject

+ (instancetype)action:(NSString *)title handler:(void (^)(void))handler;

+ (instancetype)cancelAction;
+ (instancetype)doneAction;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) void (^actionHandler)(void);

@end
