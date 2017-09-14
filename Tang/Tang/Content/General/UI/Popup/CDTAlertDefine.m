//
//  CDTAlertDefine.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/5/12.
//  Copyright © 2017年 来电科技 All rights reserved.
//

#import "CDTAlertDefine.h"

@interface CDTAlertDefine ()
@property (assign, readwrite, nonatomic) CDTAlertType type;
@property (copy, readwrite, nonatomic) NSString *webImage;
@end

@implementation CDTAlertDefine

- (instancetype)init
{
    return [self initWithType:CDTAlertCustom];
}

- (instancetype)initWithType:(CDTAlertType)type
{
    self = [super init];
    if (self) {
        self.type = type;
        [self setup];
    }
    return self;
}

- (void)setup
{
    switch (self.type) {
        case CDTAlertCustom:{
            
        }   break;
        case CDTAlertNetworkErr:{
            self.image = [UIImage imageNamed:@"icon_popup_nonetwork"];
            self.message = @"网络不给力\n请检查你的网络，稍后再试";
            self.actions = @[[CDTAlertAction doneAction]];
        }   break;
        case CDTAlertSuccess:{
            self.image = [UIImage imageNamed:@"icon_popup_success"];
            self.message = @"";
            self.actions = @[[CDTAlertAction doneAction]];
        }   break;
        case CDTAlertFail:{
            self.image = [UIImage imageNamed:@"icon_popup_unsuccess"];
            self.message = @"";
            self.actions = @[[CDTAlertAction doneAction]];
        }   break;
        case CDTAlertInfo:{
            self.image = [UIImage imageNamed:@"icon_popup_warning"];
            self.message = @"";
            self.actions = @[[CDTAlertAction doneAction]];
        }   break;
    }
}

@end
