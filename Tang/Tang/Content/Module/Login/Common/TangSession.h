//
//  TangSession.h
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TangUser.h"

#define SESSION [TangSession session]
#define ME [SESSION user];
#define LOGINED [SESSION valid]

@interface TangSession : NSObject

+ (instancetype)session;

@property (strong, readonly, nonatomic) TangUser *user;
@property (assign, readonly, nonatomic) BOOL authExpired;

- (BOOL)valid;
- (void)logined:(TangUser *)user;
- (void)logout;

- (void)checkAuthExpires;


- (void)beginLoginProcess;

@end


YG_EXTERN NSString *const kTangSessionUserDidLoginedNotification;
YG_EXTERN NSString *const kTangSessionUserDidLogoutNotification;
YG_EXTERN NSString *const kTangSessionDidAuthExpiredNotification;
