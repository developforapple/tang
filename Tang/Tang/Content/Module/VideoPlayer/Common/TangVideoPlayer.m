//
//  TangVideoPlayer.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangVideoPlayer.h"

@interface TangVideoPlayer ()
@property (strong, nonatomic) AVPlayer *player;
@end

@implementation TangVideoPlayer

+ (instancetype)player
{
    static TangVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [TangVideoPlayer new];
    });
    return player;
}

- (void)play:(NSString *)url inView:(TangPlayerView *)view
{
    if (self.player) {
        [self.player pause];
        self.player = nil;
    }
    
    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:url]];
    view.player = self.player;
    [self.player play];
}

@end
