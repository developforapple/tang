//
//  TangPlayerView.swift
//  Tang
//
//  Created by Tiny on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import AVFoundation

class TangPlayerView: UIView {
    
    var player : AVPlayer? {
        set {
            self.playerLayer.player = newValue
        }
        get {
            return self.playerLayer.player
        }
    }

    override class var layerClass : AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
    
    var playerLayer : AVPlayerLayer {
        get {
            return self.layer as! AVPlayerLayer
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
    }
}
