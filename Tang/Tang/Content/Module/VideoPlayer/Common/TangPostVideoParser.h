//
//  TangPostVideoParser.h
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TangPost.h"

@class TangVideoBaseData;

@interface TangPostVideoParser : NSObject


/**
 解析一个post中的视频播放资源地址，同步返回。
 此方法可能会很耗时，请在子线程调用。

 @param post post
 @return base data
 */
+ (TangVideoBaseData *)parsePost:(TangPost *)post;

@end


typedef NS_ENUM(NSUInteger, TangVideoSource) {
    TangVideoSourceTumblr,
    TangVideoSourceInstagram,
    TangVideoSourceOther
};

FOUNDATION_EXTERN NSInteger const kTangFieldUnknown;

@interface TangVideoBaseData : NSObject <NSCopying,NSCoding>
@property (assign, nonatomic) TangVideoSource from;     //视频来源
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *thumbnail;        //缩略图,为首帧截图
@property (copy, nonatomic) NSString *filmstrip;        //预览图，为一个横向长图
@property (assign, nonatomic) NSInteger filmstripWidth; //预览图中一幅图的宽度
@property (assign, nonatomic) NSInteger filmstripHeight;//预览图中一幅图的高度
@property (assign, nonatomic) NSTimeInterval duration;  //视频长度，秒
@property (copy, nonatomic) NSString *source;           //视频资源地址：@"ttps://bellygangstaboo.tumblr.com/video_file/t:BMrTvf3wo5X5ez59rRyYGQ/165430770545/tumblr_owdoq5dCt31r85l5t"
@property (copy, nonatomic) NSString *type;             //视频类型  mp4 等
@property (copy, nonatomic) NSString *video;            //视频原始地址。可通过资源地址提取出来。也可以通过请求资源地址，服务器重定向到原始地址。后者是保险的做法。
@end
