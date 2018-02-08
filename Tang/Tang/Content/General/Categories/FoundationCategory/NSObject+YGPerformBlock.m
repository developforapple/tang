//
//  NSObject+YGPerformBlock.m
//  Golf
//
//  Created by bo wang on 2016/12/8.
//  Copyright © 2016年 WangBo. All rights reserved.
//

#import "NSObject+YGPerformBlock.h"

@implementation NSObject (YGPerformBlock)

- (void)performBlock:(YGPerformBlock)block
{
    [self performBlock:block afterDelay:0];
}

- (void)performBlock:(YGPerformBlock)block afterDelay:(NSTimeInterval)delay
{
    if (!block) return;
    SEL sel = @selector(_YGPerformBlockSelector:);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:sel object:nil];
    [self performSelector:sel withObject:[block copy] afterDelay:delay];
}

- (void)_YGPerformBlockSelector:(YGPerformBlock)block
{
    block();
}

@end
