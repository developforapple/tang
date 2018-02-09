//
//  UIScrollView+Ext.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    var automaticallyAdjustsScrollViewInsets : Bool {
        get {
            if #available(iOS 11.0, *) {
                return contentInsetAdjustmentBehavior == .automatic
            }
            return false
        }
        set {
            if #available(iOS 11.0, *) {
                contentInsetAdjustmentBehavior = newValue ? .automatic : .never
            }
        }
    }
    
}
