//
//  TEST.m
//  Tang
//
//  Created by Jay on 2017/9/19.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TEST.h"

#define VIDEOURL @"https://ig-l-a-a.akamaihd.net/h-ak-igx/t50.2886-16/21537558_499136247114272_4841138959679488000_n.mp4"

@implementation TEST

+ (instancetype)test
{
    static TEST *test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [TEST new];
        
        test.data1 = [NSMutableData data];
        test.data2 = [NSMutableData data];
    });
    return test;
}

- (void)abc
{
    [self.data1 writeToFile:[AppDocumentsPath stringByAppendingPathComponent:@"1"] atomically:YES];
    [self.data2 writeToFile:[AppDocumentsPath stringByAppendingPathComponent:@"2"] atomically:YES];
    
    [self.data1 appendData:self.data2];
    [self.data1 writeToFile:[AppDocumentsPath stringByAppendingPathComponent:@"3"] atomically:YES];
    
    NSLog(@"");
}

- (void)download
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:VIDEOURL]];
    [request addValue:@"bytes=0-2000000" forHTTPHeaderField:@"Range"];
    self.task1 = [session dataTaskWithRequest:request];
    [self.task1 resume];
}

- (void)download2
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:VIDEOURL]];
    [request addValue:@"bytes=2000001-4809431" forHTTPHeaderField:@"Range"];
    self.task2 = [session dataTaskWithRequest:request];
    [self.task2 resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    NSLog(@"%@",resp.allHeaderFields);
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    if (dataTask == self.task1) {
        [self.data1 appendData:data];
    }else{
        [self.data2 appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    NSLog(@"%@ completed  error: %@",task,error);
    if (self.task1.state == NSURLSessionTaskStateCompleted &&
        self.task2.state == NSURLSessionTaskStateCompleted) {
        [self abc];
    }
}

@end
