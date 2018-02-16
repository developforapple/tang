//
//  THUD.m
//  Tang
//
//  Created by wwwbbat on 2018/2/12.
//  Copyright © 2018年 Tiny. All rights reserved.
//

#import "THUD.h"

@implementation THUD

@end

@implementation SVProgressHUD (Ext)

+ (void)show:(NSString *)text
{
    [self showImage:nil status:text];
}

@end
