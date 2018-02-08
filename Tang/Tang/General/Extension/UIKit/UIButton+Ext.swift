//
//  UIButton+Ext.swift
//  Laidian
//
//  Created by Jay on 2018/2/2.
//  Copyright © 2018年 来电科技. All rights reserved.
//

import Foundation
import UIKit
import YYCategories

extension UIButton {
    
    private static var kNormalBGImageColorKey = Int8(0)
    /// 设置在normal状态下的背景颜色
    @IBInspectable var normalBGImageColor_ : UIColor? {
        get{
            return objc_getAssociatedObject(self, &UIButton.kNormalBGImageColorKey) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &UIButton.kNormalBGImageColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let v = newValue {
                setBackgroundImage(UIImage.init(color: v), for: .normal)
            }else{
                setBackgroundImage(nil, for: .normal)
            }
        }
    }
    
    private static var kHighlightBGImageColorKey = Int8(1)
    /// 设置在highlighted状态下的背景颜色
    @IBInspectable var highlightBGImageColor_ : UIColor? {
        get{
            return objc_getAssociatedObject(self, &UIButton.kHighlightBGImageColorKey) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &UIButton.kHighlightBGImageColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let v = newValue {
                setBackgroundImage(UIImage.init(color: v), for: .highlighted)
            }else{
                setBackgroundImage(nil, for: .highlighted)
            }
        }
    }
    
    private static var kSelectedBGImageColorKey = Int8(2)
    /// 设置在selected状态下的背景颜色
    @IBInspectable var selectedBGImageColor_ : UIColor? {
        get{
            return objc_getAssociatedObject(self, &UIButton.kSelectedBGImageColorKey) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &UIButton.kSelectedBGImageColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let v = newValue {
                setBackgroundImage(UIImage.init(color: v), for: .selected)
            }else{
                setBackgroundImage(nil, for: .selected)
            }
        }
    }
    
    private static var kDisabledBGImageColorKey = Int8(3)
    /// 设置在disabled状态下的背景颜色
    @IBInspectable var disabledBGImageColor_ : UIColor? {
        get{
            return objc_getAssociatedObject(self, &UIButton.kDisabledBGImageColorKey) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &UIButton.kDisabledBGImageColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let v = newValue {
                setBackgroundImage(UIImage.init(color: v), for: .disabled)
            }else{
                setBackgroundImage(nil, for: .disabled)
            }
        }
    }
}
