//
//  YGTabBarCtrl.h
//
//  Created by WangBo (developforapple@163.com) on 2017/3/5.
//  Copyright © 2017年 WangBo. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, YGTabType) {
    // 对应tab的索引值
    YGTabTypeHome = 0,
    YGTabTypeDiscover = 1,
    YGTabTypeDownload = 2,
    YGTabTypeMine = 3
};

#ifndef DefaultTabBarCtrl
    #define DefaultTabBarCtrl [YGTabBarCtrl defaultTabBarCtrl]
#endif

#ifndef YGCurNaviCtrl
    #define YGCurNaviCtrl [DefaultTabBarCtrl navigationOfTab:(YGTabType)[DefaultTabBarCtrl selectedIndex]]
#endif

#ifndef YGHomeNaviCtrl
    #define YGHomeNaviCtrl [DefaultTabBarCtrl navigationOfTab:YGTabTypeHome]
#endif

#ifndef YGDiscoverNaviCtrl
    #define YGDiscoverNaviCtrl [DefaultTabBarCtrl navigationOfTab:YGTabTypeDiscover]
#endif

#ifndef YGDownloadNaviCtrl
    #define YGDownloadNaviCtrl [DefaultTabBarCtrl navigationOfTab:YGTabTypeDownload]
#endif

#ifndef YGMineNaviCtrl
    #define YGMineNaviCtrl [DefaultTabBarCtrl navigationOfTab:YGTabTypeMine]
#endif

@interface YGTabBarCtrl : UITabBarController

@property (class, readonly, atomic) YGTabBarCtrl *instance;

- (UINavigationController *)navigationOfTab:(YGTabType)type;

@end
