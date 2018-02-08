//
//  TangPlayerTransition.m
//  Tang
//
//  Created by Jay on 2017/9/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangPlayerTransition.h"

@interface TangPlayerTransitionContext ()
@property (assign, readwrite, nonatomic) TangTransitionType type;
@property (strong, readwrite, nonatomic) UIImage *focusImage;
@end

@implementation TangPlayerTransitionContext

- (void)setFocusView:(UIView *)focusView
{
    _focusView = focusView;
    self.focusImage = [focusView snapshotImage];
}

@end

@interface TangPlayerTransition () <UIViewControllerTransitioningDelegate>
@end

@implementation TangPlayerTransition

+ (instancetype)transition
{
    static TangPlayerTransition *transition;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transition = [TangPlayerTransition new];
        transition.animator = [TangPlayerAnimationController new];
    });
    return transition;
}

- (void)showPlayer:(UIViewController *)playerViewCtrl
fromViewController:(UIViewController *)fromViewCtrl
           context:(TangPlayerTransitionContext *)context
{
    self.animator.context = context;
    playerViewCtrl.modalPresentationStyle = UIModalPresentationCustom;
    playerViewCtrl.transitioningDelegate = self;
    [fromViewCtrl presentViewController:playerViewCtrl animated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    self.animator.context.type = TangTransitionTypePresent;
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.context.type = TangTransitionTypeDismiss;
//    return self.animator;
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(nullable UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
{
    return nil;
}

@end

@implementation TangPlayerAnimationController

static NSTimeInterval kTangPresentAnimationStep1 = 0.5f;
static NSTimeInterval kTangPresentAnimationStep2 = 0.5f;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.context.type == TangTransitionTypePresent) {
        return kTangPresentAnimationStep1 + kTangPresentAnimationStep2;
    }
    return 0.f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = transitionContext.containerView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if (self.context.type == TangTransitionTypePresent) {
        
        UIView *transitionView = [[UIView alloc] initWithFrame:container.bounds];
        transitionView.backgroundColor = [UIColor clearColor];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:transitionView.bounds];
        [transitionView addSubview:effectView];
        
        UIImageView *focusView = [[UIImageView alloc] initWithImage:self.context.focusImage];
        focusView.contentMode = UIViewContentModeScaleAspectFit;
        focusView.clipsToBounds = YES;
        focusView.frame = [self.context.focusView convertRect:self.context.focusView.bounds toView:self.context.focusView.window];
        [effectView.contentView addSubview:focusView];
        
        [container addSubview:transitionView];
        
        // 开始动画

        // 显示模糊背景
        [UIView animateWithDuration:kTangPresentAnimationStep1 animations:^{
            effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        } completion:^(BOOL finished) {
            
            // 模糊背景变黑，图像移动到屏幕中央
            [UIView animateWithDuration:kTangPresentAnimationStep2 animations:^{
                transitionView.backgroundColor = [UIColor blackColor];
                focusView.frame = transitionView.bounds;
                
            } completion:^(BOOL finished) {
                
                [container addSubview:toView];
                [fromView removeFromSuperview];
                [transitionView removeFromSuperview];
                
                // 完成动画
                [transitionContext completeTransition:YES];
            }];
        }];
        
        
    }else if (self.context.type == TangTransitionTypeDismiss){
        
        
    }
    
    [transitionContext completeTransition:YES];
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    
}

@end

@implementation TangPlayerInteractionController

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //todo
}

- (CGFloat)completionSpeed
{
    return 0; //todo
}

- (UIViewAnimationCurve)completionCurve
{
    return UIViewAnimationCurveEaseInOut;//todo
}

@end
