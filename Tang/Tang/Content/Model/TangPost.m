//
//  TangPost.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangPost.h"

@interface TangPost () <YYModel>

@end

@implementation TangPost

YYModelDefaultCode

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"notes":[NSDictionary class],
             @"player":[TangPlayerInfo class],
             @"tags":[NSString class],
             @"trail":[NSDictionary class]};
}

@end
