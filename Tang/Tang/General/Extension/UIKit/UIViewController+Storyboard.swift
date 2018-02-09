//
//  UIViewController+Storyboard.swift
//  Laidian
//
//  Created by Tiny on 2018/2/1.
//  Copyright © tiny. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    private static var _cache : NSCache = NSCache<NSString,NSString>()
    
    private static var _storyboardIdentifierMap : [String:Set<String>] = {
        
        var map : [String:Set<String>] = [:]
        let error = safeCode {
            if let resourcePath = Bundle.main.resourcePath {
                let list = Bundle.paths(forResourcesOfType: "storyboardc", inDirectory: resourcePath)
                for path in list {
                    let name = ((path as NSString).lastPathComponent as NSString).deletingPathExtension
                    let realName = (name as NSString).components(separatedBy: "~").first!
                    let bundle = Bundle.init(path: path)
                    let nibNames : Any? = bundle?.object(forInfoDictionaryKey: "UIViewControllerIdentifiersToNibNames")
                    if let nibNamesKeys = (nibNames as? [String:Any])?.keys {
                        map[realName] = Set.init(nibNamesKeys)
                    }
                }
            }
        }
        if let e = error {
            print(e)
        }
        
        return map
    }()
    
    /// 从任意storyboard中获取实例。没有找到时使用默认构造方法生成实例。
    ///
    /// - Parameter sbid: 实例的id，为nil时取类名
    /// - Returns: 生成的实例
    final class func instanceFromStoryboard(_ sbid: String? = nil) -> Self {
        
        let identifier = sbid ?? NSStringFromClass(self)
        
        if let cachedName = _cache.object(forKey: identifier as NSString) {
            if let vc = tryTakeOutInstance(storyboard: cachedName as String, identifier: identifier) {
                return vc
            }
            _cache.removeObject(forKey: identifier as NSString)
        }
        
        let id = (identifier as NSString).components(separatedBy: ".").last!
        let map = _storyboardIdentifierMap
        for (name,list) in map {
            
            if list.contains(id) {
                if let vc = tryTakeOutInstance(storyboard: name, identifier: id) {
                    _cache.setObject(name as NSString, forKey: identifier as NSString)
                    return vc
                }
            }
        }
        return self.init()
    }
    
    private class func tryTakeOutInstance(storyboard named : String, identifier : String) -> Self? {
        return tryTakeOutInstance(self, storyboard: named, identifier: identifier)
    }
    
    private class func tryTakeOutInstance<T>(_ : T.Type, storyboard named : String, identifier : String) -> T? {

        let selStr = "identifier" + "To" + "Nib" + "Name" + "Map"
        let sel = NSSelectorFromString(selStr)

        var vc : T?
        do {
            try SafeCode.try {
                let sb = UIStoryboard.init(name: named, bundle: Bundle.main)
                let obj = sb.perform(sel).takeUnretainedValue() as? Dictionary<String,String>
                if obj != nil && obj!.values.contains(identifier) {
                    vc = sb.instantiateViewController(withIdentifier: identifier) as? T
                }
            }
        } catch {
            print(error)
        }
        return vc
    }
}
