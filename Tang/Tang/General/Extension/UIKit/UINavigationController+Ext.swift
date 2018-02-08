//
//  UINavigationController+Ext.swift
//  Laidian
//
//  Created by Jay on 2018/1/31.
//  Copyright © 2018年 来电科技. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /// 从栈底开始，找到的第一个目标控制器
    ///
    /// - Parameter cls: 控制器类
    /// - Returns: 实例
    func findFirst(of cls : AnyClass) -> UIViewController? {
        return findAll(of:cls)?.first
    }
    
    /// 从栈顶开始，找到的第一个目标控制器
    ///
    /// - Parameter cls: 控制器类
    /// - Returns: 实例
    func findLast(of cls : AnyClass) -> UIViewController? {
        return findAll(of:cls)?.last
    }
    
    /// 栈中全部目标类型的控制器
    ///
    /// - Parameter cls: 控制器类
    /// - Returns: 实例数组
    func findAll(of cls : AnyClass) -> [UIViewController]? {
        return self.viewControllers.filter { (vc) -> Bool in
            return vc.isKind(of: cls)
        }
    }
    
    /// 控制器前面的控制器。没找到或者控制器不在堆栈中，返回nil
    ///
    /// - Parameter vc: 视图控制器
    /// - Returns: 前一个控制器
    func findPervious(of vc : UIViewController) -> UIViewController? {
        return perviousAll(of:vc)?.last
    }
    
    /// 控制器后面的控制器。没找到或者控制器不在堆栈中，返回nil
    ///
    /// - Parameter vc: 视图控制器
    /// - Returns: 后一个控制器
    func findNext(of vc : UIViewController) -> UIViewController? {
        return nextAll(of:vc)?.first
    }
    
    /// 控制器底部的全部控制器。控制器不在堆栈中，返回nil。没找到，返回空数组
    ///
    /// - Parameter vc: 视图控制器
    /// - Returns: 数组 or nil
    func perviousAll(of vc : UIViewController) -> [UIViewController]? {
        guard let index = viewControllers.index(of: vc) else { return nil }
        return Array(viewControllers[0..<index])
    }
    
    /// 控制器上方的全部控制器。控制器不在堆栈中，返回nil。没找到，返回空数组
    ///
    /// - Parameter vc: 视图控制器
    /// - Returns: 数组 or nil
    func nextAll(of vc : UIViewController) -> [UIViewController]? {
        guard let index = viewControllers.index(of: vc) else { return nil }
        guard topViewController! !== vc else { return [] }
        return Array(viewControllers[(index+1)...])
    }
    
    /// 替换栈中的一个控制器。无动画。
    ///
    /// - Parameters:
    ///   - origin: 原有控制器
    ///   - new: 新控制器
    func replace(_ origin : UIViewController, _ new : UIViewController) {
        guard let index = viewControllers.index(of: origin), !viewControllers.contains(new) else {return}
        var stack = viewControllers
        stack[index] = new
        setViewControllers(stack, animated: false)
    }
    
    /// 替换栈顶控制器
    ///
    /// - Parameters:
    ///   - to: 新控制器
    ///   - animated: 是否有动画
    func redirect(top to : UIViewController, animated : Bool = true) {
        if viewControllers.contains(to) {
            popToViewController(to, animated: animated)
        }else if let top = topViewController {
            push(to, afterPopBefore: top, animated: animated)
        }else{
            pushViewController(to, animated: animated)
        }
    }
    
    /// pop到指定class的控制器后，push新的控制器，默认有动画
    ///
    /// - Parameters:
    ///   - vc: push的控制器
    ///   - to: pop回的控制器类
    ///   - animated: 是否有动画
    func push(_ vc : UIViewController, afterPopTo to: AnyClass, animated : Bool = true) {
        if let popto = findFirst(of:to) {
            push(vc, afterPopTo: popto, animated: animated)
        }
    }
    
    /// pop到指定控制器后，push新的控制器，默认有动画
    ///
    /// - Parameters:
    ///   - vc: push的控制器
    ///   - to: pop回的控制器
    ///   - animated: 是否有动画
    func push(_ vc : UIViewController, afterPopTo to: UIViewController, animated : Bool = true) {
        guard !viewControllers.contains(vc) else {return}
        
        if let index = viewControllers.index(of: to) {
            var stack = Array.init(viewControllers[0...index])
            stack.append(vc)
            setViewControllers(stack, animated: animated)
        }else{
            pushViewController(vc, animated: animated)
        }
    }
    
    /// pop到指定class之前的控制器后，push新的控制器，默认有动画
    ///
    /// - Parameters:
    ///   - vc: push的控制器
    ///   - before: pop到此控制器之前
    ///   - animated: 是否有动画
    func push(_ vc : UIViewController, afterPopBefore before: AnyClass, animated : Bool = true) {
        if let popBefore = findFirst(of:before) {
            push(vc, afterPopBefore: popBefore, animated: animated)
        }
    }
    
    /// pop到指定控制器之前的控制器后，push新的控制器，默认有动画
    ///
    /// - Parameters:
    ///   - vc: push的控制器
    ///   - before: pop到此控制器之前
    ///   - animated: 是否有动画
    func push(_ vc : UIViewController, afterPopBefore before: UIViewController, animated : Bool = true) {
        guard !viewControllers.contains(vc) else {return}
        
        if let pervious = findPervious(of:before) {
            // 找到前一个控制器
            push(vc, afterPopTo: pervious, animated: animated)
        }else if let first = viewControllers.first, first === before {
            // 栈仅有1个控制器
            setViewControllers([vc], animated: animated)
        }else{
            pushViewController(vc, animated: animated)
        }
    }
}
