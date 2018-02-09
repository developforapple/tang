//
//  TangVideoInfo.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

enum TangVideoSource : Int {
    case `default`
    case instagram
    case other
}

class TangVideoInfo: NSObject {

    var from = TangVideoSource.default  //视频来源
    var id : String?
    var thumbnail : String?         //缩略图,为首帧截图
    var filmstrip : String?         //预览图，为一个横向长图
    var filmstripWidth : Int?       //预览图中一幅图的宽度
    var filmstripHeight : Int?      //预览图中一幅图的高度
    var duration : TimeInterval?    //视频长度，秒
    var source : String!    //视频资源地址：@"ttps://bellygangstaboo.tumblr.com/video_file/t:BMrTvf3wo5X5ez59rRyYGQ/165430770545/tumblr_owdoq5dCt31r85l5t"
    var type : String!  //视频类型  mp4 等
    var video : String? //视频原始地址。可通过资源地址提取出来。也可以通过请求资源地址，服务器重定向到原始地址。后者是保险的做法。
    
}
