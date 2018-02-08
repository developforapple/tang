//
//  Config_Archive.c
//
//  Created by WangBo (developforapple@163.com) on 2017/5/5.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#include "Config_Archive.h"

#if InHouseVersion
NSString *const kAppChannel = @"InHouse";
NSString *const kAppChannelID = @"0";
#else
NSString *const kAppChannel = @"App Store";
NSString *const kAppChannelID = @"1";
#endif
