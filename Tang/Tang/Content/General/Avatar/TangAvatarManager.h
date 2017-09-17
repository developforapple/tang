//
//  TangAvatarManager.h
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TangAvatarSize) {
    TangAvatarSize16 = 16,
    TangAvatarSize24 = 24,
    TangAvatarSize30 = 30,
    TangAvatarSize40 = 40,
    TangAvatarSize48 = 48,
    TangAvatarSize64 = 64,
    TangAvatarSize96 = 96,
    TangAvatarSize128 = 128,
    TangAvatarSize512 = 512,
    TangAvatarSizeDefault = TangAvatarSize40
};

@interface TangAvatarManager : NSObject

+ (instancetype)manager;


- (NSString *)avatar:(NSString *)blogName;

- (NSString *)avatar:(NSString *)blogName size:(TangAvatarSize)size;


@end
