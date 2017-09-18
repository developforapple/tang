//
//  TangVideoPlayer.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangVideoPlayer.h"
#import "TangVideoLoader.h"

@interface TangVideoPlayer () <TangVideoLoaderDelegate>
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) dispatch_queue_t loaderQueue;

@property (strong, nonatomic) TangVideoLoader *loader;

@end

@implementation TangVideoPlayer

+ (instancetype)player
{
    static TangVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [TangVideoPlayer new];
        player.loaderQueue = dispatch_queue_create("TangVideoPlayerResourceLoader", DISPATCH_QUEUE_CONCURRENT);
    });
    return player;
}

- (void)play:(NSString *)url inView:(TangPlayerView *)view
{
    if (self.player) {
        [self.player pause];
        self.player = nil;
    }
    
    self.loader = [[TangVideoLoader alloc] init];
    self.loader.delegate = self;
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil];
    [asset.resourceLoader setDelegate:self.loader queue:self.loaderQueue];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset automaticallyLoadedAssetKeys:nil];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    if (iOS10) {
        player.automaticallyWaitsToMinimizeStalling = NO;
    }
    
    self.player = view.player = player;
    [self.player play];
}

@end
