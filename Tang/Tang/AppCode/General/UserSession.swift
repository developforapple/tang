//
//  UserSession.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

var ME : TangUser? {
    get {
        return UserSession.session.user
    }
}

let kTangSessionUserDidLoginedNotification = NSNotification.Name.init("kTangSessionUserDidLoginedNotification")
let kTangSessionUserDidLogoutNotification = NSNotification.Name.init("kTangSessionUserDidLogoutNotification")
let kTangSessionDidAuthExpiredNotification = NSNotification.Name.init("kTangSessionDidAuthExpiredNotification")

private let kTangUserSaveKey = "UserSaveKey"

class UserSession: NSObject {
    
    static let session : UserSession = UserSession()

    private override init() {
        
    }
    
    fileprivate(set) var user : TangUser? = {
        guard let data = UserDefaults.standard.object(forKey: kTangUserSaveKey) as? Data else {return nil}
        return TangUser.fromJson(data)
    }()
    fileprivate(set) var authExpired : Bool = false
    
    var valid : Bool {
        get {
            return user != nil && !authExpired
        }
    }
    
    func logined(_ user : TangUser) {
        self.user = user
        save(user)
        NotificationCenter.default.post(name: kTangSessionUserDidLoginedNotification, object: user)
    }
    
    func logout() {
        self.user = nil
        save(nil)
        NotificationCenter.default.post(name: kTangSessionUserDidLogoutNotification, object: nil)
    }
    
    func checkAuthExpires() {
        // TODO
    }
    
    func beginLoginProcess() {
        let vc = TangLoginGuideViewCtrl.instanceFromStoryboard()
        
        
        // TODO
        
//        TangLoginGuideViewCtrl *vc = [TangLoginGuideViewCtrl instanceFromStoryboard];
//        [vc show];
    }
    
    private func save(_ user : TangUser?) {
        guard user != nil else {
            UserDefaults.standard.removeObject(forKey: kTangUserSaveKey)
            return
        }
        if let data = user?.toJson() {
            UserDefaults.standard.set(data, forKey: kTangUserSaveKey)
        }
    }
}
