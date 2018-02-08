//
//  TangLoginViewCtrl.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import SDWebImage

class TangLoginViewCtrl: YGBaseViewCtrl {
    
    private static let kTangLoginBackgroundImageCacheKey = "login_background_img"
    private static let kTangLoginPage = "https://www.tumblr.com"
    
    var didLogined : (()->Void)?
    
    @IBOutlet var bgImageView : UIImageView!
    @IBOutlet var oauthBtn : UIButton!
    @IBOutlet var alertInfoLabel : UILabel!
    @IBOutlet var postInfoLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertInfoLabel.text = String.init(format: alertInfoLabel.text!, AppDisplayName)
        let cachedImage = Cache.appCache().object(forKey: TangLoginViewCtrl.kTangLoginBackgroundImageCacheKey) as? String
        bgImageView.sd_setImage(with: URL.init(string: (cachedImage ?? "")), completed: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(logined(_:)), name: kTangSessionUserDidLoginedNotification, object: nil)
        
        loadLoginPageInfo()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func logined(_ noti : NSNotification) {
        if let block = self.didLogined {
            block()
        }
    }
    
    private func loadLoginPageInfo() {
        RunOnGlobal {
            let url = URL.init(string: TangLoginViewCtrl.kTangLoginPage)
            guard let data = try? Data.init(contentsOf: url!, options: .mappedIfSafe), data.count > 10 else{
                return
            }
            
            let root = TFHpple.init(htmlData: data)
            
            // img info
            let imgNode = root?.search(withXPathQuery: "//img[@id='fullscreen_post_image']").first as? TFHppleElement
            if let imgSrc = imgNode?.object(forKey: "src") {
                print("login background image src : ",imgSrc)
                RunOnMain {
                    Cache.appCache().setObject(imgSrc as NSString, forKey: TangLoginViewCtrl.kTangLoginBackgroundImageCacheKey)
                    let options : SDWebImageOptions = [.progressiveDownload,.continueInBackground,.retryFailed]
                    self.bgImageView.sd_setImage(with: URL.init(string: imgSrc), placeholderImage: nil, options: options, completed: nil)
                }
            }
            
            // post info
            let postInfoNode = root?.search(withXPathQuery: "//div[@class='post_info just_tumblelog']").first as? TFHppleElement
            if let postInfo = postInfoNode?.object(forKey: "data-tumblelog") {
                RunOnMain {
                    self.postInfoLabel.text = String.init(format: "图片由 %@ 发布", postInfo)
                }
            }
        }
    }
    
    @IBAction func OAuthStart(_ sender : Any){
        API.instance.OAuth()
    }
}
