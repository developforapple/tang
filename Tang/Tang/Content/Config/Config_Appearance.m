//
//  Config_Appearance.c
//
//  Created by WangBo (developforapple@163.com) on 2017/5/5.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#include "Config_Appearance.h"

static NSString *kNaviTitleImageName_ = @"laidian_logo_name";

static NSMutableDictionary *kColorDict_(void){
    static NSMutableDictionary *kColorDict__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kColorDict__ = [NSMutableDictionary dictionary];
    });
    return kColorDict__;
}
#define kColorDict kColorDict_()

static UIColor *colorWithHexString(NSString *string){
    if (!string) return nil;
    UIColor *c = kColorDict[string];
    if (c) return c;
    
    c = [UIColor colorWithHexString:string];
    kColorDict[c] = c;
    return c;
}


UIColor *_kBlueColor()      { return colorWithHexString(@"0484FA"); }
UIColor *_kBlueColorBegin() { return colorWithHexString(@"00a0f7"); }
UIColor *_kBlueColorEnd()   { return colorWithHexString(@"2869db"); }
UIColor *_kRedColor()       { return colorWithHexString(@"f62971"); }
UIColor *_kRedColorBegin()  { return colorWithHexString(@"f34535"); }
UIColor *_kRedColorEnd()    { return colorWithHexString(@"b3048e"); }
UIColor *_kOrgColor()       { return colorWithHexString(@"ff4000"); }
UIColor *_kTextColor()      { return colorWithHexString(@"444444"); }
UIColor *_kSubTextColor()   { return colorWithHexString(@"999999"); }
UIColor *_kLightTextColor() { return colorWithHexString(@"C9C9C9"); }
UIColor *_kLineColor()      { return colorWithHexString(@"F5F5F5"); }
UIColor *_kDisableColor()   { return colorWithHexString(@"dadada"); }
NSString *_kNaviTitleImageName(){ return kNaviTitleImageName_;};

