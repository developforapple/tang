//
//  TangPlayerView.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import AVFoundation

class TangPlayerView: UIView {

    override class var layerClass : AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
    
    var playerLayer: AVPlayerLayer {
        get {
            return self.layer as! AVPlayerLayer
        }
    }
}
