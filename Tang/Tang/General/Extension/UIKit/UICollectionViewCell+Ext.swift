//
//  UICollectionViewCell+Ext.swift
//  Laidian
//
//  Created by Tiny on 2018/2/2.
//  Copyright © tiny. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    private func _getSelectedBackgroundView() -> UIView {
        if selectedBackgroundView == nil {
            selectedBackgroundView = UIView.init()
        }
        return selectedBackgroundView!
    }
    
    @IBInspectable var selectedBackgroundColor_ : UIColor? {
        get{
            return _getSelectedBackgroundView().backgroundColor
        }
        set{
            let view = _getSelectedBackgroundView()
            view.backgroundColor = newValue
            selectedBackgroundView = view
        }
    }
    
}
