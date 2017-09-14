//
//  TangUser.m
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangUser.h"

@interface TangUser ()<YYModel>
@end

@implementation TangUser

YYModelDefaultCode

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"blogs":[TangBlog class]};
}

@end
