//
//  Cache.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import YYCache

class Cache: NSObject {
    
    private static let appCacheKey = "universal"
    private static var cachePool : [String:YYCache] = [:]
    
    static func appCache() -> YYCache {
        return cache(appCacheKey)
    }
    
    static func cache(_ uid : String) -> YYCache {
        
        if let tmp = cachePool[uid] {
            return tmp
        }
        
        let name = AppBundleID + ".cachePool." + uid
        if let tmp = YYCache.init(name: name) {
            cachePool[uid] = tmp
            return tmp
        }
        return appCache()
    }
}
