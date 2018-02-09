//
//  UIView+Ext.swift
//  Laidian
//
//  Created by Tiny on 2018/2/1.
//  Copyright © tiny. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Geometry
extension UIView {
    var x : CGFloat {
        get {return frame.minX}
        set {frame.origin.x = newValue}
    }
    var y : CGFloat {
        get {return frame.minY}
        set {frame.origin.y = newValue}
    }
    var w : CGFloat {
        get {return frame.width}
        set {frame.size.width = newValue}
    }
    var h : CGFloat {
        get {return frame.height}
        set {frame.size.height = newValue}
    }
}

// MARK: - UIView IBInspectable

extension UIView {
    
    @IBInspectable var masksToBounds_ : Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    @IBInspectable var cornerRadius_ : CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth_ : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor_ : UIColor? {
        get {
            if let c = layer.borderColor {
                return UIColor.init(cgColor: c)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor_ : UIColor? {
        get {
            if let c = layer.shadowColor {
                return UIColor.init(cgColor: c)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowRadius_ : CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOpacity_ : Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset_ : CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
}

// MARK: - UIView Hierarchy
extension UIView {
    
    /// 找到指定Class的最近的父View
    ///
    /// - Parameter cls: 父View类型
    /// - Returns: UIView
    func findSuperView(of cls : AnyClass) -> UIView? {

        guard cls.isSubclass(of: UIView.self) else {return nil}
        guard self.isKind(of: cls) else {return self}
        
        var view : UIView? = superview
        while view != nil && !view!.isKind(of: cls) {
            view = view?.superview
        }
        return view
    }
    
    /// 找到最近的UITableView父View
    ///
    /// - Returns: UITableView or nil
    func findSuperTableView() -> UITableView? {
        return (findSuperView(of: UITableView.self) as? UITableView) ?? nil
    }
    
    /// 找到最近的UITableViewCell父View
    ///
    /// - Returns: UITableViewCell or nil
    func findSuperTableViewCell() -> UITableViewCell? {
        return (findSuperView(of: UITableViewCell.self) as? UITableViewCell) ?? nil
    }
    
    /// 找到最近的UICollectionView父View
    ///
    /// - Returns: UICollectionView or nil
    func findSuperCollectionView() -> UICollectionView? {
        return (findSuperView(of: UICollectionView.self) as? UICollectionView) ?? nil
    }
    
    /// 找到最近的UICollectionViewCell父View
    ///
    /// - Returns: UICollectionViewCell or nil
    func findSuperCollectionViewCell() -> UICollectionViewCell? {
        return (findSuperView(of: UICollectionViewCell.self) as? UICollectionViewCell) ?? nil
    }
    
    /// 一个view是否包含于self
    ///
    /// - Parameter view: 子view
    /// - Returns: 是否包含
    func contains(_ view : UIView) -> Bool {
        var tmp : UIView? = view
        while tmp != nil && tmp !== self {
            tmp = tmp!.superview
        }
        return tmp === self
    }
}

// MARK: - UIView Collapsed
extension UIView {
    private static var _kCollapsedConstraintsKey = Int8(0)
    
    /// UIView 收缩的相关约束
    @IBOutlet var collapsedConstraints : [NSLayoutConstraint]? {
        get {
            return objc_getAssociatedObject(self, &UIView._kCollapsedConstraintsKey) as? [NSLayoutConstraint]
        }
        set {
            objc_setAssociatedObject(self, &UIView._kCollapsedConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private static var _kCollapsedKey = Int8(1)
    
    /// 当前View是否是收缩状态
    var isCollapsed : Bool {
        get {
            return (objc_getAssociatedObject(self, &UIView._kCollapsedKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIView._kCollapsedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            _updateCollapsedConstraints(newValue)
        }
    }
    
    /// 设置View的收缩和恢复    
    ///
    /// - Parameters:
    ///   - collapsed: 收缩或恢复
    ///   - animated: 是否有动画
    func setCollapsed(_ collapsed : Bool, _ animated : Bool = true) {
        if animated {
            DispatchQueue.main.async {
                self.isCollapsed = collapsed
                self.superview?.layoutIfNeeded()
                self.layoutIfNeeded()
            }
        }else{
            self.isCollapsed = collapsed
        }
    }
    
    private func _updateCollapsedConstraints(_ collapsed : Bool) {
        guard let constraints = self.collapsedConstraints else { return }
        DispatchQueue.main.async {
            for aConstraint in constraints {
                let constant = aConstraint.constant
                if collapsed {
                    if constant > 0 {
                        aConstraint.trueConstant = constant
                    }
                    aConstraint.constant = 0
                }else{
                    if constant == 0 {
                        aConstraint.constant = aConstraint.trueConstant
                    }
                    aConstraint.trueConstant = aConstraint.constant
                }
            }
        }
    }
}

fileprivate extension NSLayoutConstraint {
    static var _kTrueConstantKey = Int8(3)
    var trueConstant : CGFloat {
        get {
            return objc_getAssociatedObject(self, &NSLayoutConstraint._kTrueConstantKey) as? CGFloat ?? self.constant
        }
        set {
            objc_setAssociatedObject(self, &NSLayoutConstraint._kTrueConstantKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
