//
//  Avatar.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

enum Avatar : Int {
    
    case size16 = 16
    case size24 = 24
    case size30 = 30
    case size40 = 40
    case size48 = 48
    case size64 = 64
    case size96 = 96
    case size128 = 128
    case size512 = 512
    
    private static var taskCache : [String:URLSessionTask] = [:]
    
    private static func avatarKey(_ blogName : String) -> String{
        return "avatar_" + blogName
    }
    
    static func make(_ blogName : String, size : Avatar = .size40) -> String? {
        let cache = Cache.appCache()
        if let avatar = cache.object(forKey: Avatar.avatarKey(blogName)) as? String {
            return String.init(format: avatar, size.rawValue)
        }
        requestAvatar(blogName)
        return nil
    }
    
    private static func requestAvatar(_ blogName : String) {
        guard let _ = taskCache[blogName] else { return }
        
        let task = API.instance.getAvater(blogName) { (suc, url) in
            if suc {
                Cache.appCache().setObject(url as NSString?, forKey: Avatar.avatarKey(blogName))
            }
            taskCache[blogName] = nil
        }
        taskCache[blogName] = task
    }
}
