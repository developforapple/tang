//
//  UITableView+Ext.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import Foundation
import UIKit;

extension UITableView {
    
    @IBInspectable var separatorInsetZero : Bool {
        get {
            return UIEdgeInsetsEqualToEdgeInsets(self.separatorInset, UIEdgeInsets.zero)
        }
        set {
            if newValue {
                self.separatorInset = UIEdgeInsets.zero
                if #available(iOS 8.0, *) {
                    self.layoutMargins = UIEdgeInsets.zero
                }
            }else{
                // do nothing
            }
        }
    }
    
}
