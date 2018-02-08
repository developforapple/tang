//
//  UIDevice+Ext.swift
//  Laidian
//
//  Created by Jay on 2018/1/31.
//  Copyright © 2018年 来电科技. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    static var hardwareName : String = {
        var info = utsname.init()
        uname(&info)
        let machineMirror = Mirror.init(reflecting: info.machine)
        let machine = machineMirror.children.reduce("") { (string, item) -> String in
            
            if let v = item.value as? Int8, v != 0 {
                let s = String.init(UnicodeScalar.init(UInt8(v)))
                return string + s
            }
            return string
        }
        return machine
    }()
    
    static var hardwareIsSimulator : Bool = {
        return UIDevice.hardwareName == "x86_64" || UIDevice.hardwareName == "i386"
    }()
}
