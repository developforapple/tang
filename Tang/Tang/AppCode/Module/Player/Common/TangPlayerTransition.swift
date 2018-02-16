//
//  TangPlayerTransition
//  Tang
//
//  Created by wwwbbat on 2018/2/10.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import Foundation
import UIKit

enum TangTransitionType : Int {
    case push
    case pop
    case present
    case dismiss
}

private let PresentAnimationStep1 = 0.5
private let PresentAnimationStep2 = 0.5

class TangAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    var context : TangTransitionContext!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if context.type == .present {
            return PresentAnimationStep1 + PresentAnimationStep2
        }
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        if context.type == .present {
            let transitionView = UIView.init(frame: container.bounds)
            transitionView.backgroundColor = UIColor.clear
            let effectView = UIVisualEffectView.init(frame: transitionView.bounds)
            transitionView.addSubview(effectView)
            
            let focusView = UIImageView.init(image: context.focusImage)
            focusView.contentMode = .scaleAspectFit
            focusView.clipsToBounds = true
            focusView.frame = context.focusView.convert(context.focusView.bounds, to: context.focusView.window!)
            effectView.contentView.addSubview(focusView)
            
            container.addSubview(transitionView)
            
            // Step1
            UIView.animate(withDuration: PresentAnimationStep1, animations: {
                effectView.effect = UIBlurEffect.init(style: .dark)
            }, completion: { (_) in
                
                // Step2
                UIView.animate(withDuration: PresentAnimationStep2, animations: {
                    
                    transitionView.backgroundColor = UIColor.black
                    focusView.frame = transitionView.bounds
                    
                }, completion: { (_) in
                    
                    container.addSubview(toView!)
                    fromView?.removeFromSuperview()
                    transitionView.removeFromSuperview()
                    
                    transitionContext.completeTransition(true)
                })
            })
        }else if context.type == .dismiss {
            transitionContext.completeTransition(true)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}

class TangInteraction : NSObject, UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    var completionSpeed: CGFloat {
        get {
            return 0
        }
    }
    
    var completionCurve: UIViewAnimationCurve {
        get {
            return UIViewAnimationCurve.easeInOut
        }
    }
}

class TangTransitionContext : NSObject {
    var focusView : UIView! {
        didSet {
            focusImage = focusView.snapshotImage(afterScreenUpdates: false)
        }
    }
    fileprivate(set) var type : TangTransitionType!
    fileprivate(set) var focusImage : UIImage!
}

class TangPlayerTransition : NSObject {
    
    static let instance = TangPlayerTransition()
    
    fileprivate var animator : TangAnimator = TangAnimator()
    fileprivate var interaction : TangInteraction!
    
    private override init() {
        
    }
    
    func show(_ viewCtrl : UIViewController, from : UIViewController, context : TangTransitionContext) {
        animator.context = context
        viewCtrl.modalPresentationStyle = .custom
        viewCtrl.transitioningDelegate = self
        from.present(viewCtrl, animated: true, completion: nil)
    }
    
}

extension TangPlayerTransition : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.context.type = .present
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.context.type = .dismiss
        return nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
