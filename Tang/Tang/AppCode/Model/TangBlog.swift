//
//  TangBlog.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangBlog : Codable {
    
    var admin               : Bool?
    var ask                 : Bool?
    var ask_anon            : Bool?
    var ask_page_title      : String?
    var can_send_fan_mail   : Bool?
    var can_subscribe       : Bool?
    var description         : String    = ""
    var drafts              : Int = 0
    var facebook            : String?
    var facebook_opengraph_enabled : String?
    var followed            : Bool      = false
    var followers           : Int       = 0
    var is_adult            : Bool?
    var is_blocked_from_primary : Bool?
    var is_nsfw             : Bool?
    var likes               : Int       = 0
    var messages            : Int       = 0
    var name                : String?
    var posts               : Int       = 0
    var primary             : Bool?
    var queue               : Int       = 0
    var reply_conditions    : String?
    var share_likes         : Bool?
    var subscribed          : Bool?
    var title               : String?
    var total_posts         : Int       = 0
    var tweet               : String?
    var twitter_enabled     : Bool?
    var twitter_send        : Bool?
    var type                : String?
    var updated             : Date?
    var url                 : String?
}
