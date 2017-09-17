//
//  TangSession.m
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangSession.h"
#import "TangLoginGuideViewCtrl.h"

@interface TangSession ()
@property (strong, readwrite, nonatomic) TangUser *user;
@property (assign, readwrite, nonatomic) BOOL authExpired;
@end

@implementation TangSession

+ (instancetype)session
{
    static TangSession *s;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [TangSession new];
    });
    return s;
}

- (BOOL)valid
{
    return nil != self.user && !self.authExpired;
}

- (void)logined:(TangUser *)user
{
    self.user = user;
    
    if (user){
        [[NSNotificationCenter defaultCenter] postNotificationName:kTangSessionUserDidLoginedNotification object:self.user];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kTangSessionUserDidLogoutNotification object:nil];
    }
}

- (void)logout
{
    [self logined:nil];
}

- (void)checkAuthExpires
{
    //TODO
}

- (void)beginLoginProcess
{
    TangLoginGuideViewCtrl *vc = [TangLoginGuideViewCtrl instanceFromStoryboard];
    [vc show];
}


@end

NSString *const kTangSessionUserDidLoginedNotification = @"TangSessionUserDidLoginedNotification";
NSString *const kTangSessionUserDidLogoutNotification = @"TangSessionUserDidLogoutNotification";
NSString *const kTangSessionDidAuthExpiredNotification = @"TangSessionDidAuthExpiredNotification";
