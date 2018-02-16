//
//  StringUtils.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/12.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import Foundation

extension String {
    
    static func readableTimeInterval(_ sec : TimeInterval) -> String {
        return readableTimeInterval(Int(sec))
    }
    
    static func readableTimeInterval(_ sec : Float) -> String {
        return readableTimeInterval(TimeInterval(sec))
    }
    
    static func readableTimeInterval(_ sec : CGFloat) -> String {
        return readableTimeInterval(TimeInterval(sec))
    }
    
    static func readableTimeInterval(_ sec : Int) -> String {
        var result : String!
        switch sec {
        case ..<60:     result = String.init(format: "00:%02d", sec)
        case 60..<3600: result = String.init(format: "%02d:%02d", sec/60, sec%60)
        case 3600...:   result = String.init(format: "%02d:%02d:%02d", sec/3600, sec%3600/60, sec%60)
        default:    break
        }
        return result
    }
}
