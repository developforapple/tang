//
//  TangAPI.h
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

YG_EXTERN NSString *const kTangOAuthScheme;

typedef NSURLSessionTask * TASK;

@interface TangAPI : NSObject

+ (instancetype)instance;

- (BOOL)handleURL:(NSURL *)url;

- (void)requestOAuth;


#pragma mark - Blog

- (TASK)loadDashboard:(NSUInteger)offset
           completion:(void(^)(BOOL suc,NSArray *result))completion;

#pragma mark - User

// 获取到的baseUrl中，尺寸位置以%d代替
- (TASK)fetchAvatar:(NSString *)blogName
         completion:(void (^)(BOOL suc,NSString *baseUrl))completion;

@end

#define API [TangAPI instance]
