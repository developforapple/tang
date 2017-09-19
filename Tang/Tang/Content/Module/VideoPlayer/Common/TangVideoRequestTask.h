//
//  TangVideoRequestTask.h
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TangVideoRequestTask;
@class TangVideoData;
@class AVAssetResourceLoadingRequest;

@protocol TangVideoRequestTaskDelegate <NSObject>
@required
- (void)reqeustTask:(TangVideoRequestTask *)task didReceiveData:(NSData *)data atRange:(NSRange)range;
@end

@interface TangVideoRequestTask : NSObject

// 当前下载的进度位置
@property (assign, nonatomic) long long offset;

// 起始位置
@property (assign, nonatomic) long long beginAt;

// 总长度
@property (assign, nonatomic) long long videoLength;

// 剩余下载长度
@property (assign, nonatomic) long long remain;

// 数据同时会保存到文件中
@property (strong, nonatomic) NSFileHandle *file;

// 视频分段下载时，一个视频任务可包含多个请求，一个请求结束或者被取消时，需要从列表中去除。
@property (strong, nonatomic) NSMutableArray<AVAssetResourceLoadingRequest *> *requests;

// 视频数据，下载的请求到的数据将会保存进这里
@property (strong, nonatomic) TangVideoData *data;

@end
