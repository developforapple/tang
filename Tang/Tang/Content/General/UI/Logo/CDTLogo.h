//
//  CDTLogo.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/8/29.
//  Copyright © 2017年 来电科技 All rights reserved.
//

#import <Foundation/Foundation.h>

#define Logo_56 [CDTLogo logo_56]

@interface CDTLogo : NSObject

+ (UIImage *)logo:(CGSize)size;
+ (UIImage *)logo:(CGSize)size mode:(UIViewContentMode)mode;
+ (UIImage *)logo:(CGSize)size cornerRadius:(CGFloat)radius;
+ (UIImage *)logo:(CGSize)size cornerRadius:(CGFloat)radius mode:(UIViewContentMode)mode;


+ (UIImage *)logo_56;

@end
