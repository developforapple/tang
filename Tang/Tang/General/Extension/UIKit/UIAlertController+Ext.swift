//
//  UIAlertController+Ext.swift
//  Laidian
//
//  Created by Tiny on 2018/1/31.
//  Copyright © tiny. All rights reserved.
//

import Foundation
import UIKit.UIAlertController

extension UIAlertController {
    
    /// Debug弹窗
    ///
    /// - Parameter message: Debug消息
    @objc class func debug(_ message : String) {
        if DEBUG_MODE {
            alert(title: nil, message: message)
        }
    }
    
    /// 单按钮提示弹窗
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 消息
    ///   - callback: 回调
    @objc class func alert(title : String?, message : String? = nil, callback : CodeBlock? = nil ) {

        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .cancel, handler: { (action) in
            if let cb = callback {
                cb()
            }
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /// 双按钮确认弹窗
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 消息
    ///   - callback: 回调
    @objc class func confirm(title : String?, message : String? = nil, callback : ((_ isCancel : Bool)->Void)? = nil) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            if let c = callback {
                c(false)
            }
        }))
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            if let c = callback {
                c(true)
            }
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

