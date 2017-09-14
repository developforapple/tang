//
//  Config_Appearance.h
//
//  Created by WangBo (developforapple@163.com) on 2017/5/5.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#ifndef Config_Appearance_h
#define Config_Appearance_h

#include "Defines.h"
#include "ConfigDefines.h"

@class UIColor;

YG_EXTERN UIColor *_kBlueColor(void);
YG_EXTERN UIColor *_kBlueColorBegin(void);
YG_EXTERN UIColor *_kBlueColorEnd(void);
YG_EXTERN UIColor *_kRedColor(void);
YG_EXTERN UIColor *_kRedColorBegin(void);
YG_EXTERN UIColor *_kRedColorEnd(void);
YG_EXTERN UIColor *_kOrgColor(void);
YG_EXTERN UIColor *_kTextColor(void);
YG_EXTERN UIColor *_kSubTextColor(void);
YG_EXTERN UIColor *_kLightTextColor(void);
YG_EXTERN UIColor *_kLineColor(void);
YG_EXTERN UIColor *_kDisableColor(void);
YG_EXTERN NSString *_kNaviTitleImageName(void);


// 主题蓝色系
#define kBlueColor              _kBlueColor()       //主题颜色 0484FA
#define kBlueColorBegin         _kBlueColorBegin()  //蓝色范围起始 00a0f7
#define kBlueColorEnd           _kBlueColorEnd()    //蓝色范围结束 2869db

#define kRedColor               _kRedColor()        //主红色   f62971
#define kRedColorBegin          _kRedColorBegin()   //红色范围起始    f34535
#define kRedColorEnd            _kRedColorEnd()     //红色范围结束    b3048e

#define kOrgColor               _kOrgColor()        //橙色    ff4000

#define kTextColor              _kTextColor()       //文本颜色  444444
#define kSubTextColor           _kSubTextColor()    //次级颜色  999999
#define kLightTextColor         _kLightTextColor()  //很淡的文本颜色 C9C9C9

#define kLineColor              _kLineColor()       //细线    F5F5F5
#define kDisableColor           _kDisableColor()    //失效状态背景  dadada

#define kNaviTitleImageName     _kNaviTitleImageName()  //导航栏标题图片名称


#endif /* Config_Appearance_h */
