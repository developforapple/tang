//
//  TangPlayerViewCtrl.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangPlayerViewCtrl.h"
#import "TangVideoPlayer.h"
#import "TangPlayerView.h"
#import "TangPostVideoParser.h"

@interface TangPlayerViewCtrl ()
@property (weak, nonatomic) IBOutlet TangPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIView *coverView;


@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
@property (weak, nonatomic) IBOutlet UISlider *sliderBar;
@property (weak, nonatomic) IBOutlet UIProgressView *cacheProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;


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
                [[TangVideoPlayer player] play:data.video inView:self.playerView];
            }else{
                [SVProgressHUD showErrorWithStatus:@"播放失败"];
            }
        });
    });
}

- (IBAction)exit:(id)sender
{
    [self doLeftNaviBarItemAction];
}

- (IBAction)playTimeControl:(id)sender
{
    
}



@end
