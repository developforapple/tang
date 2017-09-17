//
//  TangLoginViewCtrl.m
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangLoginViewCtrl.h"
#import "TFHpple.h"
#import "TangSession.h"
#import "BingoCache.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kTangLoginBackgroundImageCacheKey = @"login_background_img";

@interface TangLoginViewCtrl ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *oauthBtn;
@property (weak, nonatomic) IBOutlet UILabel *alertInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *postInfoLabel;

@end

@implementation TangLoginViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    NSString *tmp = self.alertInfoLabel.text;
    self.alertInfoLabel.text = [NSString stringWithFormat:tmp,AppDisplayName];
    NSString *cachedImg = (NSString *)[APPCACHE objectForKey:kTangLoginBackgroundImageCacheKey];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:cachedImg]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logined:) name:kTangSessionUserDidLoginedNotification object:nil];
    
    [self loadLoginPageInfo];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadLoginPageInfo
{
    RunOnGlobalQueue(^{
        NSString *url = @"https://www.tumblr.com";
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingMappedIfSafe error:&error];
        if (!data || data.length < 10 || error ) {
            return;
        }
        TFHpple *root = [TFHpple hppleWithHTMLData:data];
        NSArray *results = [root searchWithXPathQuery:@"//img[@id='fullscreen_post_image']"];
        TFHppleElement *imgNode = results.firstObject;
        NSString *imgSrc = [imgNode objectForKey:@"src"];
        if (imgSrc) {
            NSLog(@"background image url:%@",imgSrc);
            RunOnMainQueue(^{
                [APPCACHE setObject:imgSrc forKey:kTangLoginBackgroundImageCacheKey];
                SDWebImageOptions options = SDWebImageProgressiveDownload | SDWebImageContinueInBackground | SDWebImageRetryFailed;
                [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imgSrc] placeholderImage:self.bgImageView.image options:options];
            });
        }
        
        //post info
        TFHppleElement *postInfoNode = [root searchWithXPathQuery:@"//div[@class='post_info just_tumblelog']"].firstObject;
        NSString *postinfo = [postInfoNode objectForKey:@"data-tumblelog"];
        if (postinfo) {
            RunOnMainQueue(^{
                self.postInfoLabel.text = [NSString stringWithFormat:@"图片由 %@ 发布",postinfo];
            });
        }
    });
}

- (void)logined:(NSNotification *)noti
{
    if (self.didLogined) {
        self.didLogined();
    }
}

- (IBAction)OAuthStart:(id)sender
{
    [API requestOAuth];
}

@end
