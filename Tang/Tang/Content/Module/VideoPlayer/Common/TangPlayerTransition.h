//
//  TangPlayerTransition.h
//  Tang
//
//  Created by Tiny on 2017/9/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TangPlayerAnimationController;
@class TangPlayerInteractionController;
@class TangPlayerTransitionCoordinator;
@class TangPlayerTransition;
@class TangPlayerTransitionContext;

typedef NS_ENUM(NSUInteger, TangTransitionType) {
    TangTransitionTypePush,
    TangTransitionTypePop,
    TangTransitionTypePresent,
    TangTransitionTypeDismiss
};

@interface TangPlayerAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (strong, nonatomic) TangPlayerTransitionContext *context;
@end

@interface TangPlayerInteractionController : NSObject <UIViewControllerInteractiveTransitioning>

@end


@interface TangPlayerTransition : NSObject
+ (instancetype)transition;
@property (strong, nonatomic) TangPlayerAnimationController *animator;
@property (strong, nonatomic) TangPlayerInteractionController *interactionAnimator;
- (void)showPlayer:(UIViewController *)playerViewCtrl
fromViewController:(UIViewController *)fromViewCtrl
           context:(TangPlayerTransitionContext *)context;
@end

@interface TangPlayerTransitionContext : NSObject

@property (strong, nonatomic) UIView *focusView;

@property (assign, readonly, nonatomic) TangTransitionType type;
@property (strong, readonly, nonatomic) UIImage *focusImage;

@end
