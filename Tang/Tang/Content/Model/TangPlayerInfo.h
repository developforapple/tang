//
//  TangPlayerInfo.h
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TangPlayerInfo : NSObject <NSCopying, NSCoding>

@property (assign, nonatomic) float width;  //width of video player, in pixels
@property (copy, nonatomic) NSString *embed_code;   //HTML for embedding the video player

@end

