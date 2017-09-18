//
//  TangVideoRequestTask.h
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TangVideoRequestTask;

@protocol TangVideoRequestTaskDelegate <NSObject>
@required
- (void)reqeustTask:(TangVideoRequestTask *)task didReceiveData:(NSData *)data atRange:(NSRange)range;
@end

// 视频下载任务
@interface TangVideoRequestTask : NSObject

// 当前下载的进度位置
@property (assign, nonatomic) long long offset;

// 起始位置
@property (assign, nonatomic) long long beginAt;

// 总长度
@property (assign, nonatomic) long long videoLength;

// 剩余下载长度
@property (assign, nonatomic) long long remain;

// 下载任务下载的数据
@property (strong, nonatomic) NSMutableData *data;

// 数据同时会保存到文件中
@property (strong, nonatomic) NSFileHandle *file;

@end
