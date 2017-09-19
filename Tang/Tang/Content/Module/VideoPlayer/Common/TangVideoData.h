//
//  TangVideoData.h
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YGThreadSafety

@class TangVideoFragment;

// 数据保存方法
// 从下载器获得的数据通过此协议传递给TangVideoData保存
@protocol TangVideoDataSetter <NSObject>
@required
- (void)addData:(NSData *)data location:(NSUInteger)location YGThreadSafety;
@end

// 数据读取者
// 代理成为TangVideoData的代理，从TangVideoData获取数据
@protocol TangVideoDataGetter <NSObject>
@required
- (NSData *)getData:(NSRange)range;
@end

// 视频数据，一个视频由多个片段组成
@interface TangVideoData : NSObject <TangVideoDataSetter>

@property (weak, nonatomic) id<TangVideoDataGetter> delegate;

// 视频的片段。片段可以时是本地已缓存的数据。也可以是正在下载的数据。
@property (strong, nonatomic) NSArray<TangVideoFragment *> *fragments;

@property (strong, nonatomic) NSFileHandle *fileHandle;

@property (copy, nonatomic) NSString *url;

@property (assign, nonatomic) long long length;

// 添加数据。
// 如果已有合适的分段，数据将被拼接到此分段的末尾。
// 如果数据不能被添加到任何分段中，将会创建新的分段来保存它。
// 如果数据和已有分段有重叠，那么合并他们。
- (void)addData:(NSData *)data location:(NSUInteger)location YGThreadSafety;

// 空视频数据，没有视频片段时返回YES
- (BOOL)isEmpty;

// 视频没有任何缺失的数据时，返回YES
- (BOOL)isFully YGThreadSafety;

// 当前片段是否有重叠部分
- (BOOL)overlapped YGThreadSafety;

// 整合片段，去重。
- (void)smoothen YGThreadSafety;

// 在指定的范围内，缺失的数据的范围。
// 指定范围内的数据是断续的时，将返回第一部分缺失的数据范围。
// 指定范围内数据时完整的时，返回{range.loc+range.len,0}
// 指定的范围无效时，返回{NSNotFound,0}
- (NSRange)missingDataRangeInRange:(NSRange)range YGThreadSafety;

@end

@interface TangVideoFragment : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
// 初始化一个片段
- (instancetype)initWithURL:(NSString *)url location:(long long)location NS_DESIGNATED_INITIALIZER;
+ (instancetype)fragmentWithURL:(NSString *)url location:(long long)location;

// 原始链接。两个链接相同时，视为同一个视频。
@property (copy, readonly, nonatomic) NSString *url;

// 片段的位置
@property (assign, readonly, nonatomic) long long location;
// 片段的长度，下载时，这个长度将会根据数据更新
@property (assign, readonly, nonatomic) long long length;

// 不要直接操作data
// 缓存的数据
@property (strong, readonly, nonatomic) NSMutableData *data;
// 本地缓存路径，数据大小增加到一定程度时，将会写到此路径下
@property (copy, readonly, nonatomic) NSString *filePath;

// 获取数据
- (NSData *)getData:(NSRange)range;
// 添加数据
- (void)appendData:(NSData *)data;

// 保存为临时文件，清空data
- (void)close;

- (BOOL)isIntersectWith:(TangVideoFragment *)fragment;

@end
