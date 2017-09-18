//
//  TangVideoData.h
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TangVideoFragment.h"

/**
 视频数据，一个视频由多个片段组成
 */
@interface TangVideoData : NSObject

/**
 视频的片段。片段可以时是本地已缓存的数据。也可以是正在下载的数据。
 */
@property (strong, nonatomic) NSArray<TangVideoFragment *> *fragments;



@end
