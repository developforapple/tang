//
//  DDBasePopViewController.m
//  QuizUp
//
//  Created by Normal on 11/12/15.
//  Copyright © 2015 Bo Wang. All rights reserved.
//

#import "YGBasePopViewCtrl.h"

@interface YGBasePopViewCtrl ()
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UIWindow *previousWindow;
@end

@implementation YGBasePopViewCtrl

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    YGBasePopViewCtrl *vc = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [vc setup];
    return vc;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    YGBasePopViewCtrl *vc = [super initWithCoder:aDecoder];
    [vc setup];
    return vc;
}

- (void)setup
{
    _animationDuration = 0.2f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)initWindowWithLevel:(CGFloat)level
{
    self.view.userInteractionEnabled = NO;
    self.previousWindow = [UIApplication sharedApplication].keyWindow;
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = level;
    window.rootViewController = self;
    window.backgroundColor = [UIColor clearColor];
    window.alpha = 0.f;
    [window makeKeyAndVisible];
    self.window = window;
}

- (void)popViewWillAppear{}
- (void)popViewDidAppear{}
- (void)popViewWillDisappear{}
- (void)popViewDidDisappear{}

- (void)callWillAppear
{
    [self popViewWillAppear];
    if (self.willAppear) {
        self.willAppear(self);
    }
}

- (void)callDidAppear
{
    [self popViewDidAppear];
    if (self.didAppear) {
        self.didAppear(self);
    }
}

- (void)callWillDisappear
{
    [self popViewWillDisappear];
    if (self.willDisappear) {
        self.willDisappear(self);
    }
}

- (void)callDidDisappear
{
    [self popViewDidDisappear];
    if (self.didDisappear) {
        self.didDisappear(self);
    }
}

- (void)show
{
    [self show:UIWindowLevelNormal+1];
}

- (void)showAboveStatusBar
{
    [self show:UIWindowLevelStatusBar+1];
}

- (void)showAboveAlert
{
    [self show:2003];
}

- (void)show:(UIWindowLevel)level
{
    [self initWindowWithLevel:level];
    [self showAnimations];
}

- (void)showAnimations
{
    [self callWillAppear];
    
    self.view.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.window.alpha = 1.f;
        if (self.animations) {
            self.animations(YES);
        }
    } completion:^(BOOL finished) {
        
        self.view.userInteractionEnabled = YES;
        
        [self callDidAppear];
        
    }];
}

- (void)dismiss
{
    [self dismissAnimations];
}

- (void)dismiss:(void (^)(void))completion
{
    self.didDisappear = ^(YGBasePopViewCtrl *pop) {
        completion?completion():0;
    };
    [self dismiss];
}

- (void)dismissAnimations
{
    [self callWillDisappear];
    
    self.view.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.window.alpha = 0.f;
        if (self.animations) {
            self.animations(NO);
        }
    } completion:^(BOOL finished) {
        
        [self.window resignKeyWindow];
        [self.previousWindow makeKeyAndVisible];
        self.window = nil;
    
        [self callDidDisappear];
    }];
    
}

@end
