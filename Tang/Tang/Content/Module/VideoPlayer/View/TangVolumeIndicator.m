//
//  TangVolumeIndicator.m
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangVolumeIndicator.h"
#import <AVFoundation/AVFoundation.h>

@interface TangVolumeIndicator ()
@property (assign, readwrite, nonatomic) float volume;
@property (weak, nonatomic) IBOutlet UIView *volumeTrackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *volumeHeightConstraint;
@end

@implementation TangVolumeIndicator

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self beginAudioSession];
    }
    return self;
}

- (void)beginAudioSession
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeDidChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

- (void)dealloc
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)volumeDidChanged:(NSNotification *)noti
{
    NSDictionary *userinfo = noti.userInfo;
    NSString *str1 = userinfo[@"AVSystemController_AudioCategoryNotificationParameter"];
    NSString *str2 = userinfo[@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"];
    float volume = [userinfo[@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    
    [self updateVolume:volume];
}

- (void)updateVolume:(float)volume
{
    self.volume = volume;
    
    [self layoutIfNeeded];
    self.volumeHeightConstraint.constant = CGRectGetHeight(self.volumeTrackView.bounds) * volume;
    [self layoutIfNeeded];
}

- (IBAction)volumeIncreaseAction:(id)sender
{
    
}

- (IBAction)volumeDecreaseAction:(id)sender
{
    
}


@end
