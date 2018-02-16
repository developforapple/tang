//
//  TangVideoInfo.swift
//  Tang
//
//  Created by Tiny on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit


/// 视频信息和Post无关，如果视频资源地址相同，就任务两个Post的视频相同
class TangVideoInfo: NSObject {

    var type = TMVideoType.tumblr   // 视频的类型
    
    var duration : Int?             // 视频长度，秒
    var source : String?            // 视频最初发布的页面
    var video : String?             // 视频资源地址
    var video_page : String?        // 一个中间页，将会重定向到资源地址
    var format : String?            // 视频格式
    
    // 缩略图，一般为5张图片
    var frames : [String] = []
    var width : Int = 0
    var height : Int = 0
    
    // 封面
    var poster : String?
    
    // 幻灯片,为一个横向长图
    var filmstrip : String?
}
