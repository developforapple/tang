//
//  TangVideoPlayer.h
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TangPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface TangVideoPlayer : NSObject

+ (instancetype)player;

- (void)play:(NSString *)url inView:(TangPlayerView *)view;


@end
