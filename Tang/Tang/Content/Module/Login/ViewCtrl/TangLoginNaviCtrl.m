//
//  TangLoginNaviCtrl.m
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangLoginNaviCtrl.h"
#import "TangLoginViewCtrl.h"

@interface TangLoginNaviCtrl ()

@end

@implementation TangLoginNaviCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ygweakify(self);
    TangLoginViewCtrl *vc = [self loginViewCtrl];
    vc.didLogined = ^{
        ygstrongify(self);
        if (self.didLogined) {
            self.didLogined();
        }
    };
}

- (TangLoginViewCtrl *)loginViewCtrl
{
    UIViewController *vc = self.viewControllers.firstObject;
    if ([vc isKindOfClass:[TangLoginViewCtrl class]]) {
        return (TangLoginViewCtrl *)vc;
    }
    NSAssert(NO, @"导航控制器层级错误！");
    return nil;
}

@end
