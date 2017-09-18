//
//  TangVideoLoader.h
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TangVideoLoader;
@class TangVideoRequestTask;
@class TangVideoDownloader;
@class TangVideoRequestTask;

@protocol TangVideoLoaderDelegate <NSObject>
@required


/**
 告知代理，需要开始这个下载任务

 @param loader loader
 @param task 视频下载任务
 */
- (void)videoLoader:(TangVideoLoader *)loader loadTask:(TangVideoRequestTask *)task;

@end

/**
 负责为播放器提供数据。作为视频播放器和下载器的中介，在两者之间传递数据。
 */
@interface TangVideoLoader : NSObject <AVAssetResourceLoaderDelegate>

/**
 一个播放器只同时存在一个下载任务。为nil时，表示没有任何任务在下载。loader通过成为task的代理来接受task的回调
 */
@property (strong, nullable, nonatomic) TangVideoRequestTask *task;


/**
 发送回调给视频播放器
 */
@property (weak, nonatomic) id <TangVideoLoaderDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
