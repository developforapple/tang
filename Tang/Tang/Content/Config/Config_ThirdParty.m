//
//  Config_ThirdParty.c
//
//  Created by WangBo (developforapple@163.com) on 2017/5/5.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#include "Config_ThirdParty.h"

#if InHouseVersion
NSString *const kUMengAppKey = @"54dc5626fd98c53ac3001452";
#else
NSString *const kUMengAppKey = @"54dc5626fd98c53ac3001452";
#endif


NSString *const kQQAppID = @"1104293404";
NSString *const kQQAppKey = @"Bekay8Cbvjx9eFOR";
NSString *const kQQScheme = @"QQ41D22E1C";

// 1: Build Setting/User-Defined 中定义环境变量 BUGLY_APP_ID
// 2: Build Phases/Compile Sources/Config_ThirdParty.m 设置 Compiler Flags:
//    -D'MACRO_BUGLY_APP_ID=@"$(BUGLY_APP_ID)"
NSString *const kBuglyAppID = MACRO_BUGLY_APP_ID;


NSString *const kWeiboAppKey = @"";
NSString *const kWeiboScheme = @"";

NSString *const kWechatAppID  = @"wx1f83882082346a51";
NSString *const kWechatAppSecret = @"";
NSString *const kWechatScheme = @"wx1f83882082346a51";

#if InHouseVersion
NSString *const kBaiduAppKey = @"NmswvpnTFoL022wAf8yGhGwj";
#else
NSString *const kBaiduAppKey = @"XP5AeSOEo7KKjpjBIXdvR6Lx";
#endif


NSString *const kPgyAppID = @"7936b38af35806197a1d09f044ca9a7b";


NSString *const kAlipayScheme = @"cdtalipay";

NSString *const kZhimaAppID = @"2015122301028465";

NSString *const kUnionPayScheme = @"cdtuppay";

#if DEBUG_MODE
NSString *const kPayPalClientID = @"AUcpLj-DFofxPW8u6g17_Xv5FKyx3ii731oBUjHDxIimLZOLlcQBaXC-tct0JAqtPkGOO2gA5aByndJL";
#else
NSString *const kPayPalClientID = @"AfmR3k1azm3liMETPeKE4gOXwXTXdK9eZgBjsj1kL6X4HGzw-8Bdc9yW87zZYQI5G7TI3-mMwyR4SCih";
#endif

NSString *const kLeanCloudAppID = @"zjolahobhc7f71ujeqctili1zug7v7c868levtvv5ecf3963";
NSString *const kLeanCloudAppKey = @"wp0vpfkaw2v7q0ybe2ga5tc6wwu0gpwx779270i8h49f1hwo";

NSString *const kPingppAppID = @"app_vL4CG01iD8mTW9SW";

#if InHouseVersion
NSString *const kGaodeMapKey = @"ad43500ec50ef5c0d55882806361c273";
#else
NSString *const kGaodeMapKey = @"4119abb7eb3fbe01e0c28ab9b5b9c629";
#endif

NSString *const kTumblrConsumerKey = @"HxYYsUwrI7w844tMYYaII6PCjQ4EwqQo8G4DpJSyF5A8L2cXzq";
NSString *const kTumblrConsumerSecret = @"pN5tdNYkVN6CZBYxUBCafOsap0yTUHCZa5Fs03J1qLtXskbTdG";
