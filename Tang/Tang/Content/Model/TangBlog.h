//
//  TangBlog.h
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TangBlog : NSObject <NSCoding,NSCopying>

@property (assign, nonatomic) NSInteger admin;
@property (assign, nonatomic) NSInteger ask;
@property (assign, nonatomic) NSInteger ask_anon;
@property (copy, nonatomic) NSString *ask_page_title;
@property (assign, nonatomic) NSInteger can_send_fan_mail;
@property (assign, nonatomic) NSInteger can_subscribe;
@property (copy, nonatomic) NSString *description;
@property (assign, nonatomic) NSInteger drafts;
@property (copy, nonatomic) NSString *facebook;
@property (copy, nonatomic) NSString *facebook_opengraph_enabled;
@property (assign, nonatomic) NSInteger followed;
@property (assign, nonatomic) NSInteger followers;
@property (assign, nonatomic) NSInteger is_adult;
@property (assign, nonatomic) NSInteger is_blocked_from_primary;
@property (assign, nonatomic) NSInteger is_nsfw;
@property (assign, nonatomic) NSInteger likes;
@property (assign, nonatomic) NSInteger messages;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger posts;
@property (assign, nonatomic) NSInteger primary;
@property (assign, nonatomic) NSInteger queue;
@property (assign, nonatomic) NSInteger reply_conditions;
@property (assign, nonatomic) NSInteger share_likes;
@property (assign, nonatomic) NSInteger subscribed;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger total_posts;
@property (copy, nonatomic) NSString *tweet;
@property (assign, nonatomic) NSInteger twitter_enabled;
@property (assign, nonatomic) NSInteger twitter_send;
@property (copy, nonatomic) NSString *type;
@property (assign, nonatomic) NSInteger updated;
@property (copy, nonatomic) NSString *url;

@end

/*

admin = 1;
ask = 0;
"ask_anon" = 0;
"ask_page_title" = "Ask me anything";
"can_send_fan_mail" = 1;
"can_subscribe" = 0;
description = "";
drafts = 0;
facebook = N;
"facebook_opengraph_enabled" = N;
followed = 0;
followers = 0;
"is_adult" = 0;
"is_blocked_from_primary" = 0;
"is_nsfw" = 0;
likes = 0;
messages = 0;
name = termgwtmdg;
posts = 0;
primary = 1;
queue = 0;
"reply_conditions" = 3;
"share_likes" = 1;
subscribed = 0;
title = "\U65e0\U6807\U9898";
"total_posts" = 0;
tweet = N;
"twitter_enabled" = 0;
"twitter_send" = 0;
type = public;
updated = 0;
url = "https://termgwtmdg.tumblr.com/";
 
 */
