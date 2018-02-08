//
//  Func.swift
//  Laidian
//
//  Created by Jay on 2018/1/31.
//  Copyright © 2018年 来电科技. All rights reserved.
//

import Foundation
import UIKit

func Confine<T : Comparable>(value : T, max maxValue: T, min minValue: T ) -> T {
    return max(minValue, min(maxValue, value))
}

func RGBColor(_ R : Int,_  G : Int,_  B : Int,_  A : CGFloat) -> UIColor {
    return RGBColor(CGFloat(R)/255, CGFloat(G)/255, CGFloat(B)/255, A)
}

func RGBColor(_ R : CGFloat,_  G : CGFloat,_  B : CGFloat,_  A : CGFloat) -> UIColor {
    return UIColor.init(red: R, green: G, blue: B, alpha: A)
}

func RandomColor() -> UIColor {
    return RGBColor(Int(arc4random_uniform(256)), Int(arc4random_uniform(256)), Int(arc4random_uniform(256)), 1)
}

func VFL(_ format : String, views : [String : Any] = [:], metrics : [String : Any]? = nil) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views)
}

typealias CodeBlock = ()->Swift.Void

func RunOnMain(_ block: @escaping CodeBlock) {
    if Thread.isMainThread {
        block()
    }else{
        DispatchQueue.main.async(execute: block)
    }
}

func RunOnGlobal(_ block: @escaping CodeBlock) {
    DispatchQueue.global().async(execute: block)
}

typealias SecondTime = TimeInterval

func RunAfter(_ second : SecondTime, _ block : @escaping CodeBlock) {
    let deadline = DispatchTime.now() + second
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: block)
}

func RunPeriodic(period : SecondTime, delay : SecondTime = 0, block : @escaping CodeBlock) -> DispatchSourceTimer? {
    let source : DispatchSourceTimer = DispatchSource.makeTimerSource(queue: .main)
    source.setEventHandler(handler: DispatchWorkItem.init(block: block))
    source.schedule(deadline: DispatchTime.now() + delay, repeating: period)
    source.resume()
    return source
}
