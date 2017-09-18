//
//  TangVideoLoader.m
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangVideoLoader.h"
#import "TangVideoRequestTask.h"

@interface TangVideoLoader ()
@property (strong, nonatomic) NSMutableArray *requests;
@end

@implementation TangVideoLoader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)handleRequest:(AVAssetResourceLoadingRequest *)request
{
    if (!self.task) {
        // 初始化任务
        self.task = [TangVideoRequestTask new];
        
        
    }
    
    
    
    NSURL *URL = request.request.URL;
    long long offset = request.dataRequest.currentOffset;
}

#pragma mark - Loader Delegate
// 每一段数据的请求都会先到这里做处理
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest
{
    [self.requests addObject:loadingRequest];
    [self handleRequest:loadingRequest];
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
    
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForResponseToAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge
{
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge
{
    
}

@end
