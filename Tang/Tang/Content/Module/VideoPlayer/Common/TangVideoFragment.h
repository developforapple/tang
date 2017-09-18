//
//  TangVideoFragment.h
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TangVideoFragment : NSObject

// 原始链接。两个链接相同时，视为同一个视频。
@property (copy, nonatomic) NSString *url;

// 片段的位置
@property (assign, nonatomic) long long location;
// 片段的长度，为-1时，表示此片段还未结束下载
@property (assign, nonatomic) long long length;

// 缓存的数据
@property (strong, nonatomic) NSData *data;
// 本地缓存路径
@property (copy, nonatomic) NSString *filePath;

@end
