//
//  THUD.h
//  Tang
//
//  Created by wwwbbat on 2018/2/12.
//  Copyright © 2018年 Tiny. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface THUD : SVProgressHUD

@end

@interface SVProgressHUD (Ext)

+ (void)show:(NSString *)text;

@end
