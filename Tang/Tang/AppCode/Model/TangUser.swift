//
//  TangUser.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit


class TangUser : Codable {
    
    // Document : https://www.tumblr.com/docs/en/api/v2#user-methods
    
    var following       : Int           = 0     // The number of blogs the user is following
    var default_post_format : String?           // The default posting format - html, markdown or raw
    var name            : String?               // The user's tumblr short name
    var likes           : Int           = 0     // The total count of the user's likes
    var blogs           : [TangUserBlog]?       // Each item is a blog the user has permissions to post to, containing these fields:
    var token           : String?               // 额外的字段
    var tokenSecret     : String?               // 额外的字段
}

class TangUserBlog : Codable {
    
    var name            : String?               // the short name of the blog
    var url             : String?               // the URL of the blog
    var title           : String?               // the title of the blog
    var primary         : Bool?                 // indicates if this is the user's primary blog
    var followers       : Int           = 0     // total count of followers for this blog
    var tweet           : TMBoolean     = .N    // indicate if posts are tweeted auto, Y, N
    var facebook        : TMBoolean     = .N    // indicate if posts are sent to facebook Y, N
    var type            : String?               // indicates whether a blog is public or private
}
