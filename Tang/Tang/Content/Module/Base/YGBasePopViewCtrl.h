//
//  DDBasePopViewController.h
//  QuizUp
//
//  Created by Normal on 11/12/15.
//  Copyright © 2015 Bo Wang. All rights reserved.
//

#import "YGBaseViewCtrl.h"

@class YGBasePopViewCtrl;
typedef void (^YGBasePopAppearBlock)(YGBasePopViewCtrl *pop);

@interface YGBasePopViewCtrl : YGBaseViewCtrl

// 外部接收回调
@property (copy, nonatomic) YGBasePopAppearBlock willAppear;
@property (copy, nonatomic) YGBasePopAppearBlock didAppear;
@property (copy, nonatomic) YGBasePopAppearBlock willDisappear;
@property (copy, nonatomic) YGBasePopAppearBlock didDisappear;

// 子类接收回调
- (void)popViewWillAppear YG_Abstract_Method;
- (void)popViewDidAppear YG_Abstract_Method;
- (void)popViewWillDisappear YG_Abstract_Method;
- (void)popViewDidDisappear YG_Abstract_Method;

// 显示和隐藏时的动画时间，动画时间设置为0时，将没有动画。不会调用animations
@property (assign, nonatomic) NSTimeInterval animationDuration;
// 可以设置额外的动画内容
@property (copy, nonatomic) void (^animations)(BOOL isAppear);

// 显示高于normal，低于statusBar
- (void)show;
// 显示高于statusBar，低于alert
- (void)showAboveStatusBar;
// 显示高于alert
- (void)showAboveAlert;
// 显示在具体的level
- (void)show:(UIWindowLevel)level;

// 隐藏
- (void)dismiss;
- (void)dismiss:(void (^)(void))completion;

@end
