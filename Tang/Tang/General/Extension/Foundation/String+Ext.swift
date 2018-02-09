//
//  String+Ext.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import Foundation

extension String {
    
    var rangeOfAll : NSRange {
        get {
            return NSRange.init(location: 0, length: self.count)
        }
    }

}
