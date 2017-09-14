//
//  UIDevice+Ext.m
//
//  Created by WangBo (developforapple@163.com) on 2017/4/13.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#import "UIDevice+Ext.h"
#include <sys/utsname.h>

@implementation UIDevice (Ext)

+ (NSString *)hardwareName
{
    static NSString *hardware;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname sysInfo;
        uname(&sysInfo);
        hardware = [NSString stringWithUTF8String:sysInfo.machine];
    });
    return hardware;
}

+ (BOOL)hardwareIsSimulator
{
    NSString *name = [self hardwareName];
    return [name isEqualToString:@"x86_64"] || [name isEqualToString:@"i386"];
}

@end
