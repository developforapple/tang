//
//  TangPost.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangPost : Codable {
    
    // Document : https://www.tumblr.com/docs/en/api/v2#user-methods
    
    var blog_name       : String!       // The short name used to uniquely identify a blog
    var id              : Int!          // The post's unique ID
    var post_url        : String!       // The location of the post
    var type            : TMPostType!   // The type of post
    var timestamp       : Int!          // The time of the post, in seconds since the epoch
    var date            : String?         // The GMT date and time of the post, as a string
    var format          : TMFormat!     // The post format: html or markdown
    var reblog_key      : String?       // The key used to reblog this post
    var tags            : [String]?     // Tags applied to the post
    var bookmarklet     : Bool?         // Indicates whether the post was created via the Tumblr bookmarklet
    var mobile          : Bool?         // Indicates whether the post was created via mobile/email publishing
    var source_url      : String?       // The URL for the source of the content (for quotes, reblogs, etc.)
    var source_title    : String?       // The title of the source site
    var liked           : Bool?         // Indicates if a user has already liked a post or not
    var state           : TMPostState?  // Indicates the current state of the post
    var total_posts     : Int!          // The total number of post available for this request, useful for paginating through results
    
    // 文档中未写的字段
    
    var slug            : String?       // 和标题类似
    var short_url       : String?       //
    var summary         : String?
    var is_blocks_post_format : Bool?
//    var recommended_source
//    var recommended_color
    var followed        : Bool = false
    var note_count      : Int = 0
//    var reblog
//    var trail
    var can_like        : Bool = true
    var can_reblog      : Bool = true
    //    var can_send_in_message : Bool
//    var can_reply  : Bool
//    var display_avatar  : Bool
    
    
    final class func adapter(from : [Any]) -> [TangPost] {
        var result : [TangPost] = []
        for item in from {
            if  let dict = item as? [String:Any],
                let typeStr = dict["type"] as? String,
                let type = TMPostType(rawValue: typeStr),
                let data = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted){
                
                let post : TangPost?
                switch type {
                case .video :   post = TangVideoPost.fromJson(data)
                default:        post = TangPost.fromJson(data)
                }
                if post != nil {
                    result.append(post!)
                }
            }
        }
        return result
    }
}

class TangTextPost : TangPost {
    var title           : String?       // The optional title of the post
    var body            : String?       // The full post body
    
    private enum Key : String, CodingKey {
        case title,body
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try super.encode(to: encoder)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        title = try? container.decode(String.self, forKey: .title)
        body = try? container.decode(String.self, forKey: .body)
        try super.init(from: decoder)
    }
}

class TangPhotoPost: TangPost {
    var photos          : TangPhotos                // Photo objects with properties:
    var caption         : String?                   // The user-supplied caption
    var width           : Int = 0                   // The width of the photo or photoset
    var height          : Int = 0                   // The height of the photo or photoset
    
    private enum Key : String, CodingKey {
        case photos,caption,width,height
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(photos, forKey: .photos)
        try container.encode(caption, forKey: .caption)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try super.encode(to: encoder)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        photos = try container.decode(TangPhotos.self, forKey: .photos)
        caption = try? container.decode(String.self, forKey: .caption)
        width = (try? container.decode(Int.self, forKey: .width)) ?? 0
        height = (try? container.decode(Int.self, forKey: .height)) ?? 0
        try super.init(from: decoder)
    }
}

class TangQuotePost : TangPost {
    
}

class TangLinkPost : TangPost {
    
}

class TangChatPost : TangPost {
    
}

class TangAudioPost : TangPost {
    
}

class TangVideoPost : TangPost {
    
    class Player : Codable {
        var width       : Int = 0           // width of video player, in pixels
        var embed_code  : String!           // HTML for embedding the video playe
    }
    
    var caption         : String?           // The user-supplied caption
    var player          : [Player]          // Values vary by video source
    
    // 文档中未写的字段
    var video_url       : String?
    var thumbnail_url   : String?
    var thumbnail_width : Int = Int(Device_Width)
    var thumbnail_height : Int = 100
    var duration        : Int = 0
    var video_type      : TMVideoType? = .tumblr
    
    private enum Key : String, CodingKey {
        case caption,player,video_url,thumbnail_url,thumbnail_width,thumbnail_height,duration,video_type
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(caption, forKey: .caption)
        try container.encode(player, forKey: .player)
        try container.encode(video_url, forKey: .video_url)
        try container.encode(thumbnail_url, forKey: .thumbnail_url)
        try container.encode(thumbnail_width, forKey: .thumbnail_width)
        try container.encode(thumbnail_height, forKey: .thumbnail_height)
        try container.encode(duration, forKey: .duration)
        try container.encode(video_type, forKey: .video_type)
        try super.encode(to: encoder)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        caption = try? container.decode(String.self, forKey: .caption)
        player = (try? container.decode([Player].self, forKey: .player)) ?? []
        video_url = try? container.decode(String.self, forKey: .video_url)
        thumbnail_url = try? container.decode(String.self, forKey: .thumbnail_url)
        thumbnail_width = (try? container.decode(Int.self, forKey: .thumbnail_width)) ?? Int(Device_Width)
        thumbnail_height = (try? container.decode(Int.self, forKey: .thumbnail_height)) ?? 100
        duration = (try? container.decode(Int.self, forKey: .duration)) ?? 0
        video_type = try? container.decode(TMVideoType.self, forKey: .video_type)
        
        if video_type == nil {
            let videoTypeStr = try container.decode(String.self, forKey: .video_type)
            print("Unknown video type",videoTypeStr)
        }
        
        try super.init(from: decoder)
    }
}

class TangAnswerPost : TangPost {
    
}
