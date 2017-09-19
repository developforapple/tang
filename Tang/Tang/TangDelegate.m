//
//  TangDelegate.m
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangDelegate.h"
#import "YGTabBarCtrl.h"
#import "SVProgressHUD.h"

#import "TEST.h"

@interface TangDelegate ()
@end

@implementation TangDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupAppearance];
    [self registerThirdParty];
    
    YGTabBarCtrl *vc = [YGTabBarCtrl defaultTabBarCtrl];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];

    
    [[TEST test] download];
    [[TEST test] download2];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    [API handleURL:url];
    return YES;
}

#pragma mark - Appearance
- (void)setupAppearance
{
    [UIViewController setDefaultNavigationBarBlackStyle:YES];
    [UIViewController setDefaultNavigationBarLineHidden:YES];
    [UIViewController setDefaultNavigationBarShadowHidden:YES];
    [UIViewController setDefaultNavigationBarTextColor:[UIColor whiteColor]];
    [UIViewController setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    // 不显示默认的返回按钮
    [[UINavigationBar appearance] setBackIndicatorImage:nil];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:nil];
    
    if (iOS11){}else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, -65.f) forBarMetrics:UIBarMetricsDefault];
    }
    
    [[UITextField appearance] setTintColor:kBlueColor];
    [[UITextField appearance] setTextColor:kTextColor];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.4];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:15]];
}

#pragma mark - ThirdParty
- (void)registerThirdParty
{
    // OAuth
    API;
    
    
}

@end
