//
//  NSObject+KVCExceptionCatch.swift
//  Laidian
//
//  Created by Tiny on 2018/1/31.
//  Copyright © tiny. All rights reserved.
//

import Foundation

extension NSObject {
    
    func perform(_ delay : TimeInterval = 0, _ block: CodeBlock) {
        let sel = #selector(NSObject._perform(_:))
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: sel, object: nil)
        perform(sel, with: block, afterDelay: delay)
    }
    
    @objc private func _perform(_ block : CodeBlock) {
        block()
    }
}
