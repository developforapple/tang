//
//  TangPlayer.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/12.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import UIKit
import AVFoundation

enum TangPlayerState : Int{
    case idle
    case ready
    case playing
    case buffering
    case pause
    case stop
}

protocol TangPlayerCallback : NSObjectProtocol {
    func playerLayerIsReady(_ player : TangPlayer)
    func playerWillPlaying(_ player : TangPlayer , rate : Float)
    func playerDidPaused(_ player : TangPlayer)
    func player(_ player : TangPlayer, time : Float, total : Float)
}

class TangPlayer: NSObject {

    var videoURL : URL!
    var asset : AVURLAsset!
    var item : AVPlayerItem!
    var player : AVPlayer!
    var layer : AVPlayerLayer
    lazy var imageGenerator : AVAssetImageGenerator = {
        let generator = AVAssetImageGenerator.init(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.apertureMode = AVAssetImageGeneratorApertureMode.encodedPixels
        return generator
    }()
    var previewImages : [NSNumber:UIImage] = [:]
    
    weak var delegate : TangPlayerCallback?
    
    var periodicTimeObject : Any!
    var notificationObjects : [NSObjectProtocol] = []
    var state : TangPlayerState = .idle
    
    var curTime : Float64 {
        get {
            return CMTimeGetSeconds(player.currentTime())
        }
    }
    
    var duration : Float64 {
        get {
            return CMTimeGetSeconds(item.duration)
        }
    }
    
    var buffering : Bool {
        get {
            return item.isPlaybackBufferEmpty
        }
    }
    
    required init(url : String, layer : AVPlayerLayer, delegate : TangPlayerCallback) {

        self.videoURL = URL.init(string: url)
        self.layer = layer
        self.delegate = delegate
        
        super.init()
        
        initPlayer()
        addObserver()
    }
    
    deinit {
        clearObserver()
    }
    
    func initPlayer() {
        asset = AVURLAsset.init(url: videoURL)
        item = AVPlayerItem.init(asset: asset)
        player = AVPlayer.init(playerItem: item)
        layer.player = player
        
        if #available(iOS 10.0, *) {
            player.automaticallyWaitsToMinimizeStalling = false
        }
    }
    
    func readyToPlay() {
        play()
    }
    
    func play() {
        self.player.play()
    }
    
    func pause() {
        self.player.pause()
    }
    
    func stop() {
        
    }
    
    func seek(time: TimeInterval) {
        print("Seek to \(time)")
        let timescale = player.currentTime().timescale
        let cmtime = CMTimeMakeWithSeconds(time, timescale)
        player.seek(to: cmtime) { [unowned self](suc) in
            print("Seek completed : \(suc)")
            if suc {
                self.play()
            }
        }
    }
    
    func seek(progress : Float) {
        let p = Confine(value: progress, max: 1, min: 0)
        let time = duration * Float64(p)
        seek(time: time)
    }
}

// MARK: - Observable
extension TangPlayer {
    func addObserver() {
        
        layer.addObserverBlock(forKeyPath: #keyPath(AVPlayerLayer.isReadyForDisplay)) {[unowned self] (obj, old, new) in
            print("Player Layer is Ready For Display : ",new)
            self.delegate?.playerLayerIsReady(self)
        }
        
        item.addObserverBlock(forKeyPath: #keyPath(AVPlayerItem.status)) {[unowned self] (obj, old, new) in
            print("PlayerItem new status : ",new, " old status :",old)
            guard let status = AVPlayerItemStatus.init(rawValue: new as! Int) else {return}
            switch status {
            case .unknown:  break
            case .readyToPlay:
                self.readyToPlay()
            case .failed:
                print("PlayerItem load failed! error : ",self.item.error!)
            }
        }
        
        item.addObserverBlock(forKeyPath: #keyPath(AVPlayerItem.loadedTimeRanges)) { (obj, old, new) in
            guard let ranges = new as? [NSValue] else {return}
            
            for aRangeValue in ranges {
                let timeRange = aRangeValue.timeRangeValue
                let startSec = CMTimeGetSeconds(timeRange.start)
                let durationSec = CMTimeGetSeconds(timeRange.duration)
                let endSec = startSec + durationSec
                print("缓存：\(startSec)s - \(endSec)s 时长：\(durationSec)s")
            }
        }
        
        item.addObserverBlock(forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty)) { (obj, old, new) in
            if let isEmpty = new as? Int {
                if isEmpty == 1 {
                    print("缓冲中...")
                }
            }
        }
        
        item.addObserverBlock(forKeyPath: #keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp)) {[unowned self] (obj, old, new) in
            if let isOK = new as? Int {
                if isOK == 1 {
                    print("缓冲结束，恢复播放")
                    self.play()
                }
            }
        }
        
        // 30帧
        self.periodicTimeObject = player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 30), queue: DispatchQueue.main) { [unowned self](time) in
            let timesec = CMTimeGetSeconds(time)
            let totalsec = CMTimeGetSeconds(self.item.duration)
            print("Player time seconds : ",timesec," progress : \(timesec/totalsec*100) %")
            self.delegate?.player(self, time: Float(timesec), total: Float(totalsec))
        }
        
        player.addObserverBlock(forKeyPath: #keyPath(AVPlayer.rate)) { [weak self] (obj, old, new) in
            print("速率变化 new : \(new) old : \(old)")
            if let rate = new as? Float {
                switch rate {
                case 0:
                    print("播放暂停")
                    self?.delegate?.playerDidPaused(self!)
                case 1:
                    print("播放使用正常速率")
                    self?.delegate?.playerWillPlaying(self!, rate: rate)
                default:
                    print("播放使用 \(rate) 倍速率")
                    self?.delegate?.playerWillPlaying(self!, rate: rate)
                }
            }
        }
        
        if #available(iOS 10.0, *) {
            player.addObserverBlock(forKeyPath: #keyPath(AVPlayer.timeControlStatus)) { (obj, old, new) in
                
            }
        }
        
        registerNotifications()
    }
    
    func registerNotifications() {
        
        let obj1 = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVAudioSessionInterruption, object: nil, queue: nil) { (noti) in
            print("音频被打断")
        }
        let obj2 = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVAudioSessionRouteChange, object: nil, queue: nil) { (noti) in
            print("耳机插入或拔出")
            
            if let userInfo = noti.userInfo {
                let reasonValue = UInt(userInfo[AVAudioSessionRouteChangeReasonKey] as! Int)
                let reason = AVAudioSessionRouteChangeReason.init(rawValue: reasonValue)
                let previous = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription
            }
            
        }
        let obj3 = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { (noti) in
            print("播放完毕！")
            
        }
        let obj4 = NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil, queue: nil) { (noti) in
            print("播放失败！")
        }
        let obj5 = NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemPlaybackStalled, object: nil, queue: nil) { (noti) in
            print("播放异常！")
        }
        let obj6 = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { (noti) in
            print("App失去焦点")
        }
        let obj7 = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { (noti) in
            print("App获得焦点")
        }
        
        notificationObjects = [obj1,obj2,obj3,obj4,obj5,obj6,obj7]
    }
    
    func clearObserver() {
        layer.removeObserverBlocks()
        item.removeObserverBlocks()
        player.removeTimeObserver(self.periodicTimeObject)
        
        for object in notificationObjects {
            NotificationCenter.default.removeObserver(object)
        }
    }
}

// MARK: - Preview
extension TangPlayer {
    
//    // 每30秒取一张
//    func nearestPreviewImage(of time : TimeInterval) -> TimeInterval {
//
//
//
//    }
    
    
//    func getPreviewImage(at timeSec : TimeInterval) -> UIImage? {
//
//        imageGenerator.cancelAllCGImageGeneration()
//
//        let cmtime = CMTimeMakeWithSeconds(timeSec, item.currentTime().timescale)
//        let cmtimeV = NSValue.init(time: cmtime)
//        imageGenerator.generateCGImagesAsynchronously(forTimes: [cmtimeV]) { (_a, _b, _c, _d, _e) in
//
//        }
//
//
//        do {
//            let frameImageRef = try generator.copyCGImage(at: cmtime, actualTime: nil)
//            let frameImage = UIImage.init(cgImage: frameImageRef)
//            return frameImage
//        }catch {
//            return nil
//        }
//    }
}

// MARK: - State
extension TangPlayer {
    var isPlaying : Bool {
        get {
            if #available(iOS 10.0, *) {
                return player.timeControlStatus == .playing
            }else{
                return player.rate > 0
            }
        }
    }
    
    var isPause : Bool {
        get {
            if #available(iOS 10.0, *) {
                return player.timeControlStatus == .paused
            }else{
                return player.rate == 0
            }
        }
    }
    
    var isLoading : Bool {
        get {
            return !item.isPlaybackLikelyToKeepUp
        }
    }
}
