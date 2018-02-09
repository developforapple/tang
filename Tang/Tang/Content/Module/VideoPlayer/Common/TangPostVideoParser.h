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

