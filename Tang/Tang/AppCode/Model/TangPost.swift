//
//  TangPost.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangPost : Codable {
    var blog_name : String? //The short name used to uniquely identify a blog
    var can_like : Int?
    var can_reblog : Int?
    var can_reply : Int?
    var can_send_in_message : Int?
    var date : String?
    var display_avatar : String?
    var followed : Int?
    var format : String?
    var html5_capable : Int?
    var id : String?
    var is_blocks_post_format : Int?
    var liked : Int?
    var note_count : Int?
//    var notes : [Codable]?
    var permalink_url : String? //原始链接地址
    var post_url : String?      //The location of the post
//    var reblog : Codable?
    var short_url : String?
    var slug : String?
    var source_url : String?    //The URL for the source of the content (for quotes, reblogs, etc.)
    var source_title : String?  //The title of the source site
    var state : String?         //Indicates the current state of the post
    var summary : String?
    var tags : [String]?        //Tags applied to the post
    var thumbnail_height : CGFloat?
    var thumbnail_width : CGFloat?
    var thumbnail_url : String?
    var timestamp : Double?     //The time of the post, in seconds since the epoch
    var total_posts : Int?      //The total number of post available for this request, useful for paginating through results
//    var trail : []?
    var type : String?          //text, quote, link, answer, video, audio, photo, chat
    var video_type : String?
    
    // for text posts
    var title : String?         //The optional title of the post
    var body : String?          //The full post body. html format
    
    // for photo posts
//    var photos : []?
    var caption : String?       //The user-supplied caption
    var width : Float?          //The width of the photo or photoset
    var height : Float?         //The height of the photo or photoset
    
    // for Quote Posts
    var text : String?          //The text of the quote (can be modified by the user when posting)
    var source : String?        //Full HTML for the source of the quote. Example: <a href="...">Steve Jobs</a>
    
    // for link Posts
//    var title : String?
    var url : String?           //The link
    var author : String?        //The author of the article the link points to
    var excerpt : String?       //An excerpt from the article the link points to
    var publisher : String?     //The publisher of the article the link points to
    //@property (strong, nonatomic) NSArray *photos;
    var description : String?   //A user-supplied description.
    
    // for video posts
    
//    var caption : String?
    var player : [TangPlayerInfo]?

    // for Answer Posts
    
    // for Chat Posts
    
    // for Audio Posts
}
