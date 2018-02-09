//
//  UISearchBar+Ext.swift
//  Laidian
//
//  Created by Tiny on 2018/2/2.
//  Copyright © tiny. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    private static var kRealBackgroundColorKey = Int8(0)
    @IBInspectable var realBackgroundColor : UIColor? {
        get {
            return objc_getAssociatedObject(self, &UISearchBar.kRealBackgroundColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &UISearchBar.kRealBackgroundColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            guard let color = newValue else { return}
            
            var alpha = CGFloat(0)
            color.getWhite(nil, alpha: &alpha)
           
            guard let cls = NSClassFromString("UISear" + "chBarBa" + "ckground") else { return }
            
            for view in subviews {
                for view2 in view.subviews {
                    if view2.isKind(of: cls) {
                        view2.backgroundColor = color
                        view2.alpha = alpha
                    }
                }
            }
        }
    }
    
    private static var kRealBackgroundImageColorKey = Int8(1)
    @IBInspectable var realBackgroundImageColor : UIColor? {
        get {
            return objc_getAssociatedObject(self, &UISearchBar.kRealBackgroundImageColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &UISearchBar.kRealBackgroundImageColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if let color = newValue {
                setBackgroundImage(UIImage.init(color: color), for: .any, barMetrics: .default)
            }else{
                setBackgroundImage(nil, for: .any, barMetrics: .default)
            }
        }
    }
    
    @IBInspectable var textFieldTintColor : UIColor? {
        get {
            return self.textField?.tintColor
        }
        set {
            self.textField?.tintColor = newValue
        }
    }
    
    var textField : UITextField? {
        get {
            for view in subviews {
                for view2 in view.subviews {
                    if view2 is UITextField {
                        return view2 as? UITextField
                    }
                }
            }
            return nil
        }
    }
    
    var cancelButton : UIButton? {
        get {
            for view in subviews {
                for view2 in view.subviews {
                    if view2 is UIButton {
                        return view2 as? UIButton
                    }
                }
            }
            return nil
        }
    }
}
