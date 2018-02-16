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
import KTVHTTPCache
import IJKMediaFramework
import ReactiveCocoa
import ReactiveSwift

class TangPlayerViewCtrl: YGBaseViewCtrl {
    
    @IBOutlet weak var playerContainer: TangPlayerView!
    @IBOutlet weak var previewView: TangPreviewView!
    @IBOutlet weak var coverView : UIView!
    @IBOutlet weak var controlView : TangPlayerControl!
    
    private var player : TangPlayer!
    private var playerController : IJKAVMoviePlayerController!
    private var playerView : UIView!
    
    var data : TangPlayerSharedData!
    private var post : TangVideoPost {
        get {
            return data.post
        }
    }
    private var info : TangVideoInfo? {
        get {
            return data.info
        }
    }
    private var autoPlayFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !autoPlayFlag {
            autoPlayFlag = true
            prepare()
        }
    }
    
    deinit {
        
    }

    private func initUI() {
        
        self.previewView.show(data.focusImage)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func prepare() {
        SVProgressHUD.show()
        data.getVideoInfo { [unowned self] (info) in
            SVProgressHUD.dismiss()
            self.initPlayer()
        }
    }
    
    private func initPlayer() {
        if let info = self.info, let video = info.video {
            let proxyURL = KTVHTTPCache.proxyURLString(withOriginalURLString: video)
            print("Play video : \(video), proxyURL : \(proxyURL!) ")
            self.player = TangPlayer.init(url: proxyURL!, layer: self.playerContainer.playerLayer, delegate: self)
        }else{
            SVProgressHUD.showError(withStatus: "播放失败")
        }
    }
    
    @IBAction func exit(_ sender : Any) {
        self.player = nil
        doLeftNaviBarItemAction()
    }
}

extension TangPlayerViewCtrl : TangPlayerCallback {

    func playerLayerIsReady(_ player: TangPlayer) {
        self.previewView.isHidden = true
    }
    
    func player(_ player: TangPlayer, time: Float, total: Float) {
        controlView.update(time, total)
    }
    
    func player(_ player: TangPlayer, state: TangPlayerState) {
        print("Player state : ",state)
    }
    
    func playerWillPlaying(_ player: TangPlayer, rate: Float) {
        
    }
    
    func playerDidPaused(_ player: TangPlayer) {
        
    }
}

extension TangPlayerViewCtrl : TangPlayerControlCallback {
    
    func playerControl(_ control: TangPlayerControl, slider state: TangPlayerControlSlidingState, value: Float) {
        switch state {
        case .begin:
            player.pause()
            updateWillSeekHUD(seek: player.curTime)
        case .update:
            updateWillSeekHUD(seek: player.duration * Float64(value))
            break
        case .end:
            SVProgressHUD.dismiss()
            player.seek(progress: value)
        case .cancel:
            SVProgressHUD.dismiss()
        }
    }
    
    func playerControl(_ control: TangPlayerControl, changePlayback state: TangPlaybackState) {
        switch state {
        case .idle: break
        case .loading:  break
        case .playing:
            player.play()
        case .pause:
            player.pause()
        case .end:  break
        }
    }
    
    func updateWillSeekHUD(seek to : Float64) {
        let text = String.readableTimeInterval(to) + " / " + String.readableTimeInterval(player.duration)
        SVProgressHUD.show(text)
    }
}
