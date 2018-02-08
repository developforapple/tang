//
//  TangPlayerViewCtrl.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangPlayerViewCtrl.h"
#import "TangPlayerView.h"
#import "TangPostVideoParser.h"
@import AVFoundation;
@import ReactiveObjC;
#import <KTVHTTPCache/KTVHTTPCache.h>

@interface TangPlayerViewCtrl ()
@property (weak, nonatomic) IBOutlet TangPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIView *coverView;


@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
@property (weak, nonatomic) IBOutlet UISlider *sliderBar;
@property (weak, nonatomic) IBOutlet UIProgressView *cacheProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@property (strong, nonatomic) AVPlayer *player;

@end

@implementation TangPlayerViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    
    [self play];
}

- (void)initUI
{
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(16, 16)];
    image = [image imageByRoundCornerRadius:image.size.width/2];
    [self.sliderBar setThumbImage:image forState:UIControlStateNormal];
    [self.sliderBar setThumbImage:image forState:UIControlStateHighlighted];
    [self.sliderBar setThumbImage:image forState:UIControlStateSelected];
}

- (void)play
{
    [SVProgressHUD show];
    RunOnGlobalQueue(^{
        TangVideoBaseData *data = [TangPostVideoParser parsePost:self.post];
        RunOnMainQueue(^{
            [SVProgressHUD dismiss];
            if (data) {
                
                NSString *proxyURL = [KTVHTTPCache proxyURLStringWithOriginalURLString:data.video];
                self.player = [AVPlayer playerWithURL:[NSURL URLWithString:proxyURL]];
                self.playerView.playerLayer.player = self.player;
                [self addObserver];
                [self.player play];

            }else{
                [SVProgressHUD showErrorWithStatus:@"播放失败"];
            }
        });
    });
}

- (void)addObserver
{
    
//    ygweakify(self);
//    [RACObserve(self.player, duration)
//     subscribeNext:^(id x) {
//         ygstrongify(self);
//         NSInteger remain = self.player.duration * self.player.progress;
//         self.countdownLabel.text = [NSString stringWithFormat:@"%02d:%02d",remain/60,remain%60];
//     }];
//    [RACObserve(self.player, progress)
//     subscribeNext:^(id x) {
//         ygstrongify(self);
//         self.sliderBar.value = self.player.progress;
//         NSInteger remain = self.player.duration * self.player.progress;
//         self.countdownLabel.text = [NSString stringWithFormat:@"%02d:%02d",remain/60,remain%60];
//     }];
}

- (IBAction)exit:(id)sender
{
//    [self.player stop];
    self.player = nil;
    [self doLeftNaviBarItemAction];
}

- (IBAction)playTimeControl:(id)sender
{
    
}



@end
