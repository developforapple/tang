//
//  TangAPI.h
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

YG_EXTERN NSString *const kTangOAuthScheme;

@interface TangAPI : NSObject

+ (instancetype)instance;

- (BOOL)handleURL:(NSURL *)url;

- (void)requestOAuth;


@end

#define API [TangAPI instance]
