//
//  TangPlayerViewCtrl.swift
//  Tang
//
//  Created by Tiny on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD

class TangPlayerViewCtrl: YGBaseViewCtrl {

    var post : TangPost!
    var info : TangVideoInfo?
    
    @IBOutlet var playerView : TangPlayerView!
    @IBOutlet var coverView : UIView!
    @IBOutlet var controlView : UIView!
    @IBOutlet var loadingActivity : UIActivityIndicatorView!
    @IBOutlet var sliderBar : UISlider!
    @IBOutlet var cacheProgressBar : UIProgressView!
    @IBOutlet var countdownLabel : UILabel!
    
    var player : AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        play()
    }

    func initUI() {
        
        let image = UIImage.init(color: UIColor.white, size: CGSize.init(width: 16, height: 16))
        let image2 = image?.byRoundCornerRadius(image!.size.width/2)
        
        sliderBar.setThumbImage(image2, for: .normal)
        sliderBar.setThumbImage(image2, for: .highlighted)
        sliderBar.setThumbImage(image2, for: .selected)
    }
    
    func play() {
        
        SVProgressHUD.show()
        
        RunOnGlobal {
            self.info = VideoParser.parse(self.post)
            RunOnMain {
                SVProgressHUD.dismiss()
                if let info = self.info {
                    
                    // TODO
//                    NSString *proxyURL = [KTVHTTPCache proxyURLStringWithOriginalURLString:data.video];
//                    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:proxyURL]];
//                    self.playerView.playerLayer.player = self.player;
//                    [self addObserver];
//                    [self.player play];
                    
                }else{
                    SVProgressHUD.showError(withStatus: "播放失败")
                }
            }
        }
        
    }
    
    @IBAction func exit(_ sender : Any) {
        self.player = nil
        doLeftNaviBarItemAction()
    }

    @IBAction func playTimeControl(_ sender : Any) {
        
    }
}
