//
//  TangTabBarCtrl.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import UIKit

enum TangTabType : Int {
    case home = 0
    case discover
    case download
    case mine
}

class TangTabBarCtrl: UITabBarController {

    static var `default` : TangTabBarCtrl! {
        get {
            return TangTabBarCtrlHolder.instance.tabBarCtrl
        }
    }
    
    static var current : UINavigationController! {
        get {
            let ctrl = TangTabBarCtrl.default!
            return ctrl.navigationController(of: ctrl.type)
        }
    }
    
    static var home  : UINavigationController! {
        get {
            return TangTabBarCtrl.default?.navigationController(of: .home)
        }
    }
    
    static var discover : UINavigationController! {
        get {
            return TangTabBarCtrl.default?.navigationController(of: .discover)
        }
    }
    
    static var download : UINavigationController! {
        get {
            return TangTabBarCtrl.default?.navigationController(of: .download)
        }
    }
    
    static var mine : UINavigationController! {
        get {
            return TangTabBarCtrl.default?.navigationController(of: .mine)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TangTabBarCtrlHolder.instance.tabBarCtrl = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        TangTabBarCtrlHolder.instance.tabBarCtrl = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = TangTabBarCtrlHolder.instance
    }
    
    var type : TangTabType {
        get {
            return TangTabType.init(rawValue: selectedIndex) ?? .home
        }
    }
    
    private func navigationController(of tabType : TangTabType) -> UINavigationController? {
        let idx = tabType.rawValue
        if let vcs = viewControllers, idx < vcs.count {
            return vcs[idx] as? UINavigationController
        }
        return nil
    }
}

fileprivate class TangTabBarCtrlHolder : NSObject, UITabBarControllerDelegate {
    
    var tabBarCtrl : TangTabBarCtrl!
    static var instance = TangTabBarCtrlHolder()
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
}
