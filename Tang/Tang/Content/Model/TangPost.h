//
//  TangPost.h
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TangPlayerInfo.h"

@interface TangPost : NSObject <NSCoding,NSCopying>

@property (copy, nonatomic) NSString *blog_name;    //The short name used to uniquely identify a blog
@property (assign, nonatomic) BOOL can_like;
@property (assign, nonatomic) BOOL can_reblog;
@property (assign, nonatomic) BOOL can_reply;
@property (assign, nonatomic) BOOL can_send_in_message;
@property (copy, nonatomic) NSString *date;         //The GMT date and time of the post, as a string
@property (assign, nonatomic) BOOL display_avatar;
@property (assign, nonatomic) int followed;
@property (copy, nonatomic) NSString *format;       //The post format: html or markdown
@property (assign, nonatomic) int html5_capable;
@property (copy, nonatomic) NSString *id;           //The post's unique ID
@property (assign, nonatomic) BOOL is_blocks_post_format;
@property (assign, nonatomic) int liked;            //Indicates if a user has already liked a post or not
@property (assign, nonatomic) int note_count;
@property (strong, nonatomic) NSArray *notes;
@property (copy, nonatomic) NSString *permalink_url; //原始链接地址
@property (copy, nonatomic) NSString *post_url;     //The location of the post
@property (strong, nonatomic) NSDictionary *reblog;

//"reblog_key" = ubrLxWhY;  //The key used to reblog this post
//"reblogged_from_can_message" = 0;
//"reblogged_from_following" = 0;
//"reblogged_from_id" = 165217877809;
//"reblogged_from_name" = stimmystuffs;
//"reblogged_from_title" = "Great!";
//"reblogged_from_url" = "http://stimmystuffs.com/post/165217877809/httpsinstagramcompby3ek3dhudh";
//"reblogged_from_uuid" = "stimmystuffs.tumblr.com";
//"reblogged_root_can_message" = 0;
//"reblogged_root_following" = 0;
//"reblogged_root_id" = 165217877809;
//"reblogged_root_name" = stimmystuffs;
//"reblogged_root_title" = "Great!";
//"reblogged_root_url" = "http://stimmystuffs.com/post/165217877809/httpsinstagramcompby3ek3dhudh";
//"reblogged_root_uuid" = "stimmystuffs.tumblr.com";

//@property (copy, nonatomic) NSString *recommended_color;
//@property (copy, nonatomic) NSString *recommended_source;
@property (copy, nonatomic) NSString *short_url;
@property (copy, nonatomic) NSString *slug;
@property (copy, nonatomic) NSString *source_url;   //The URL for the source of the content (for quotes, reblogs, etc.)
@property (copy, nonatomic) NSString *source_title; //The title of the source site
@property (copy, nonatomic) NSString *state;        //Indicates the current state of the post
@property (copy, nonatomic) NSString *summary;
@property (strong, nonatomic) NSArray<NSString *> *tags;//Tags applied to the post
@property (assign, nonatomic) float thumbnail_height;
@property (assign, nonatomic) float thumbnail_width;
@property (copy, nonatomic) NSString *thumbnail_url;
@property (assign, nonatomic) NSTimeInterval timestamp; //The time of the post, in seconds since the epoch
@property (assign, nonatomic) int total_posts; //The total number of post available for this request, useful for paginating through results
@property (strong, nonatomic) NSArray *trail;
@property (copy, nonatomic) NSString *type;  //text, quote, link, answer, video, audio, photo, chat
@property (copy, nonatomic) NSString *video_type;


// for text posts
@property (copy, nonatomic) NSString *title;    //The optional title of the post
@property (copy, nonatomic) NSString *body;     //The full post body. html format

// for photo posts
@property (strong, nonatomic) NSArray *photos;
@property (copy, nonatomic) NSString *caption;  //The user-supplied caption
@property (assign, nonatomic) float width;      //The width of the photo or photoset
@property (assign, nonatomic) float height;     //The height of the photo or photoset

// for Quote Posts
@property (copy, nonatomic) NSString *text;     //The text of the quote (can be modified by the user when posting)
@property (copy, nonatomic) NSString *source;   //Full HTML for the source of the quote. Example: <a href="...">Steve Jobs</a>

// for Link Posts
//@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;      //The link
@property (copy, nonatomic) NSString *author;   //The author of the article the link points to
@property (copy, nonatomic) NSString *excerpt;  //An excerpt from the article the link points to
@property (copy, nonatomic) NSString *publisher;//The publisher of the article the link points to
//@property (strong, nonatomic) NSArray *photos;
@property (copy, nonatomic) NSString *description_;  //A user-supplied description. 原始字段名：description

// for Chat Posts
//@property (copy, nonatomic) NSString *title;
//@property (copy, nonatomic) NSString *body;
//@property (strong, nonatomic) NSArray *dialogue;

// for Audio Posts
//@property (copy, nonatomic) NSString *caption;
//@property (copy, nonatomic) *player; //

// for Video Posts
//@property (copy, nonatomic) NSString *caption;
@property (strong, nonatomic) NSArray<TangPlayerInfo *> *player;

// for Answer Posts


@end
