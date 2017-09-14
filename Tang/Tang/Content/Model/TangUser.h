//
//  TangUser.h
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TangBlog.h"

@interface TangUser : NSObject <NSCopying,NSCoding>

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger likes;
@property (assign, nonatomic) NSInteger following;

@property (copy, nonatomic) NSString *default_post_format;

@property (strong, nonatomic) NSArray<TangBlog *> *blogs;

@end
