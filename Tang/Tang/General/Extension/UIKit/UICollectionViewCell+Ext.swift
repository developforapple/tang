//
//  UICollectionViewCell+Ext.swift
//  Laidian
//
//  Created by Jay on 2018/2/2.
//  Copyright © 2018年 来电科技. All rights reserved.
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
