//
//  TangPlaybackState.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/15.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import Foundation

@objc enum TangPlaybackState : Int {
    case idle       //未加载视频
    case loading    //读取中
    case playing    //播放中
    case pause      //已暂停
    case end        //播放结束
}
