//
//  TangLoginGuideViewCtrl.m
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangLoginGuideViewCtrl.h"
#import "TangLoginNaviCtrl.h"
#import "TangSession.h"

@interface TangLoginGuideViewCtrl ()
@property (strong, nonatomic) TangLoginNaviCtrl *loginNaviCtrl;
@end

@implementation TangLoginGuideViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)logined
{
    [SVProgressHUD show];
    RunAfter(.4f, ^{
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [self dismiss];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TangLoginNaviCtrlSegueID"]) {
        self.loginNaviCtrl = [segue destinationViewController];
        ygweakify(self);
        self.loginNaviCtrl.didLogined = ^{
            ygstrongify(self);
            [self logined];
        };
    }
}

@end
