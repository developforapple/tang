//
//  AppDelegate.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
    
    func setupAppearace() {
        
        UIViewController.setDefaultNavigationBarBlackStyle(true)
        UIViewController.setDefaultNavigationBarLineHidden(true)
        UIViewController.setDefaultNavigationBarShadowHidden(true)
        UIViewController.setDefaultNavigationBarTextColor(UIColor.white)
        UIViewController.defaultStatusBarStyle = .lightContent
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.white], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        
        UINavigationBar.appearance().backIndicatorImage = nil
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = nil
        
        if #available(iOS 11, *) {}else {
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment( UIOffset.init(horizontal: CGFloat(Int.min), vertical: -65) ,for: .default)
        }
        
        UITextField.appearance().tintColor = UIColor.blue
        UITextField.appearance().textColor = RGBColor(68, 68, 68, 1)
        
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.7))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.4)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 15))
    }
    
    func setupThirdParty() {
        
        
//        SError *error;
//        [KTVHTTPCache proxyStart:&error];
//        if (error) {
//            NSLog(@"Launch KTVHttpCache Proxy failed! %@",error);
//        }
    }
}

extension AppDelegate : UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        setupAppearace()
        setupThirdParty()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return API.instance.handleURL(url)
    }
}
