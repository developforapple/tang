//
//  TEST.h
//  Tang
//
//  Created by Jay on 2017/9/19.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEST : NSObject <NSURLSessionDataDelegate>

+ (instancetype)test;


- (void)download;

- (void)download2;


@property (strong, nonatomic) NSMutableData *data1;
@property (strong, nonatomic) NSMutableData *data2;

@property (strong, nonatomic) NSURLSessionDataTask *task1;
@property (strong, nonatomic) NSURLSessionDataTask *task2;

@end
