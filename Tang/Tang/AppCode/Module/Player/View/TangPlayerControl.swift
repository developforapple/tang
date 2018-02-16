//
//  TangPlayerControl.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/12.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import UIKit

// MARK: - Callback

@objc protocol TangPlayerControlCallback {
    func playerControl(_ control : TangPlayerControl, slider state : TangPlayerControlSlidingState, value : Float)
    func playerControl(_ control : TangPlayerControl, changePlayback state: TangPlaybackState)
}

// MARK: -
class TangPlayerControl: UIView {

    fileprivate(set) var isSliding = false
    fileprivate(set) var previousValue : Float = 0
    
    var sliderTouchUpOutsideAsCancel : Bool = false
    fileprivate(set) var state : TangPlaybackState = .idle
    
    @IBOutlet weak var delegate : TangPlayerControlCallback?
    @IBOutlet weak var cacheBar : UIProgressView!
    @IBOutlet weak var progressBar : UISlider!
    @IBOutlet weak var loadingIndicator : UIActivityIndicatorView!
    @IBOutlet weak var playButton : UIButton!
    @IBOutlet weak var countdownLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let image = UIImage.init(color: UIColor.white, size: CGSize.init(width: 16, height: 16))
        let image2 = image?.byRoundCornerRadius(image!.size.width/2)
        progressBar.setThumbImage(image2, for: .normal)
        progressBar.setThumbImage(image2, for: .highlighted)
        progressBar.setThumbImage(image2, for: .selected)
    }
}

// MARK: - Playback
extension TangPlayerControl {
    
    @IBAction func playOrPause(_ sender : Any) {
        switch self.state {
        case .idle:
            break
        case .loading:
            break
        case .playing:
            //暂停
            self.delegate?.playerControl(self, changePlayback: .pause)
        case .pause:
            // 继续播放
            self.delegate?.playerControl(self, changePlayback: .playing)
        case .end:
            // 重新播放
            self.delegate?.playerControl(self, changePlayback: .playing)
        }
    }
    
    func update(_ state : TangPlaybackState)  {
        self.state = state
        switch state {
        case .idle:
            playButton.isHidden = true
            loadingIndicator.startAnimating()
        case .loading:
            playButton.isHidden = true
            loadingIndicator.startAnimating()
        case .playing:
            playButton.isHidden = false
            playButton.setImage(UIImage.init(named: "ic_video_pause"), for: .normal)
            loadingIndicator.stopAnimating()
        case .pause:
            playButton.isHidden = false
            playButton.setImage(UIImage.init(named: "ic_video_play"), for: .normal)
            loadingIndicator.stopAnimating()
        case .end:
            playButton.isHidden = false
            playButton.setImage(UIImage.init(named: "ic_video_reload"), for: .normal)
            loadingIndicator.stopAnimating()
        }
    }
}

// MARK: - Time Line

extension TangPlayerControl {
    
    func update(_ curTime : Float, _ duration : Float) {
        guard !duration.isNaN else {return}
        if !isSliding {
            progressBar.value = curTime/duration
        }
        countdownLabel.text = String.readableTimeInterval(duration-curTime)
    }
    
    @IBAction func sliderValueChanged(_ sender : Any) {
        print("Slider value changed : ",progressBar.value)
        if isSliding {
            delegate?.playerControl(self, slider: .update, value: progressBar.value)
        }
    }
    
    @IBAction func sliderTouchDown(_ sender : Any) {
        print("Slider touch down")
        isSliding = true
        delegate?.playerControl(self, slider: .begin, value: progressBar.value)
        previousValue = progressBar.value
    }
    
    @IBAction func sliderTouchUpOutside(_ sender : Any) {
        print("Slider touch up outside")
        if sliderTouchUpOutsideAsCancel {
            sliderTouchCancel(sender)
        }else{
            sliderTouchUpInside(sender)
        }
    }
    
    @IBAction func sliderTouchCancel(_ sender : Any) {
        print("Slider touch up outside")
        isSliding = false
        progressBar.value = previousValue
        delegate?.playerControl(self, slider: .cancel, value: progressBar.value)
    }
    
    @IBAction func sliderTouchUpInside(_ sender : Any) {
        print("Slider touch up inside")
        isSliding = false
        previousValue = 0
        delegate?.playerControl(self, slider: .end, value: progressBar.value)
    }
}
