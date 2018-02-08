//
//  API.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import TMTumblrSDK
import SafariServices

class API : NSObject {
    
    typealias TASK = URLSessionTask
    @objc static let instance = API()
    
    private var appCredentials : TMAPIApplicationCredentials!
    private var userCredentials : TMAPIUserCredentials!
    
    private lazy var client : TMAPIClient = {
        let session = TMURLSession.init(configuration: URLSessionConfiguration.default, applicationCredentials: appCredentials, userCredentials: userCredentials)
        return TMAPIClient.init(session: session, requestFactory: TMRequestFactory.init())
    }()
    
    private var oauthAuthenticator : TMOAuthAuthenticator?
    private var oauthBrowser : SFSafariViewController?
    private static let kTangOAuthScheme = "tangoauth"
    
    private override init() {
        appCredentials = TMAPIApplicationCredentials.init(consumerKey: kTumblrConsumerKey0,
                                                          consumerSecret: kTumblrConsumerSecret0)
        userCredentials = TMAPIUserCredentials.init(token: ME?.token,
                                                    tokenSecret: ME?.tokenSecret)
    }
}

// MARK: - Delegate
extension API : TMOAuthAuthenticatorDelegate , TMNetworkActivityIndicatorManager{
    
    func openURL(inBrowser url: URL!) {
        RunOnMain {
            self.dismissOAuthBrowser()
            
            self.oauthBrowser = SFSafariViewController.init(url: url)
            let window = UIApplication.shared.delegate?.window!
            window?.rootViewController?.present(self.oauthBrowser!, animated: true, completion: nil)
        }
    }
    
    func setNetworkActivityIndicatorVisible(_ networkActivityIndicatorVisible: Bool) {
        RunOnMain {
            UIApplication.shared.isNetworkActivityIndicatorVisible = networkActivityIndicatorVisible
        }
    }
}

// MARK: - OAuth
extension API {
    
    func OAuth() {
        let session = TMURLSession.init(configuration: URLSessionConfiguration.default,
                                        applicationCredentials: appCredentials,
                                        userCredentials: userCredentials)
        oauthAuthenticator = TMOAuthAuthenticator.init(session: session,
                                                       applicationCredentials: appCredentials,
                                                       delegate: self)
        
        oauthAuthenticator?.authenticate(API.kTangOAuthScheme, callback: { [unowned self] (uc, error) in
            
            guard error != nil else {
                print("OAuth failed :", error!)
                return
            }
            
            print("OAuth successed! ",uc!)
            self.userCredentials = uc!
            self.updateUserInfo(uc!)
        })
    }
    
    func handleURL(_ url : URL) -> Bool {
        if let oa = oauthAuthenticator {
            return oa.handleOpen(url)
        }
        return false
    }
    
    private func dismissOAuthBrowser() {
        if let browser = self.oauthBrowser, browser.presentingViewController != nil {
            browser.dismiss(animated: true, completion: nil)
        }
        oauthBrowser = nil
    }
    
    func updateUserInfo(_ uc : TMAPIUserCredentials) {
        
        client.userInfoDataTask { [unowned self] (resp, error) in
            guard error != nil else {
                print("Request user info failed :",error!)
                return
            }
            
            print("Request user info successed :",resp)
            RunOnMain {
                self.dismissOAuthBrowser()
                
                // TODO:
//                TangUser *user = [TangUser yy_modelWithJSON:response];
//                user.token = userCredentials.token;
//                user.tokenSecret = userCredentials.tokenSecret;
//                [SESSION logined:user];
            }
        }
        
    }
}

// MARK: - API
extension API {
    func dashboard(_ offset : Int, completion : ((Bool,[Any]?) -> Void)? = nil) -> TASK {
        
        var params : [String:Any] = [:];
        
        params["limit"] = 20
        params["type"] = "video"
        params["offset"] = offset
        
        let task = client.dashboardRequest(params) { (resp, error) in
            if error != nil {
                print("load dashboard failed: ", error!)
                if let c = completion {
                    c(false,nil)
                }
            }else{
                print("load dashboard successed")
                if let c = completion {
                    let posts = resp?["posts"] as? [Any]
                    c(true,posts)
                }
            }
        }
        return task
    }
    
    func getAvater(_ blogName : String, completion : ((Bool,String?) -> Void)? = nil) -> TASK {
        return client.avatar(withBlogName: blogName, size: 16, callback: { (_data, _response, _error) in
            guard let c = completion else {return}
            guard let response = _response else{return}
            
            if _error != nil {
                RunOnMain {
                    c(false,nil)
                }
            }else{
                if let url = response.url, var components = URLComponents.init(url: url, resolvingAgainstBaseURL: false) {
                    components.fragment = nil
                    let aburl = components.string!
                    let ext = (aburl as NSString).pathExtension
                    
                    let regex = String.init(format: "_[0-9]+.%@", ext)
                    let rep = String.init(format: "_%%d.%@", ext)
                    
                    let avatar = (aburl as NSString).replacingRegex(regex, options: [], with: rep)
                    
                    RunOnMain {
                        c(true,avatar)
                    }
                }else{
                    RunOnMain {
                        c(false,nil)
                    }
                }
            }
        })
    }
}
