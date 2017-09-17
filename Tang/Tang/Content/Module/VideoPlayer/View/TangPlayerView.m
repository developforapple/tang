//
//  TangPlayerView.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation TangPlayerView

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)layer
{
    return (AVPlayerLayer *)[super layer];
}

- (void)setPlayer:(AVPlayer *)player
{
    AVPlayerLayer *layer = [self layer];
    layer.player = player;
}

@end
