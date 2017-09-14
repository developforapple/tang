//
//  YGBaseNaviCtrl.m
//
//  Created by WangBo (developforapple@163.com) on 2017/3/5.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#import "YGBaseNaviCtrl.h"

@interface YGBaseNaviCtrl ()

@end

@implementation YGBaseNaviCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
