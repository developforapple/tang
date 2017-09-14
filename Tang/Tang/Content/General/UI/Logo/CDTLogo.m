//
//  CDTLogo.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/8/29.
//  Copyright © 2017年 来电科技 All rights reserved.
//

#import "CDTLogo.h"

@implementation CDTLogo

+ (NSMutableDictionary *)cache
{
    static NSMutableDictionary *dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = [NSMutableDictionary dictionary];
    });
    return dict;
}

+ (dispatch_semaphore_t)lock
{
    static dispatch_semaphore_t semaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(1);
    });
    return semaphore;
}

+ (UIImage *)logo:(CGSize)size
{
    return [self logo:size cornerRadius:0 mode:UIViewContentModeScaleAspectFit];
}

+ (UIImage *)logo:(CGSize)size mode:(UIViewContentMode)mode
{
    return [self logo:size cornerRadius:0 mode:mode];
}

+ (UIImage *)logo:(CGSize)size cornerRadius:(CGFloat)radius
{
    return [self logo:size cornerRadius:radius mode:UIViewContentModeScaleAspectFit];
}

+ (UIImage *)logo:(CGSize)size cornerRadius:(CGFloat)radius mode:(UIViewContentMode)mode
{
    NSString *key = [NSString stringWithFormat:@"%.1f,%.1f,%.1f,%ld",size.width,size.height,radius,(long)mode];
    NSMutableDictionary *cache = [self cache];
    UIImage *logo = cache[key];
    if (!logo) {
        
        UIImage *image = [UIImage imageNamed:@"logo_1024"];
        image = [image imageByResizeToSize:size contentMode:mode];
        if (radius > 0) {
            image = [image imageByRoundCornerRadius:radius];
        }
        
        logo = image;
        cache[key] = image;
    }
    return logo;
}

+ (UIImage *)logo_56
{
    return [self logo:CGSizeMake(56, 56)];
}

@end
