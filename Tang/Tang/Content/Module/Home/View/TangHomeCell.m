//
//  TangHomeCell.m
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangHomeCell.h"
#import "TangAvatarManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const kTangHomeCell = @"TangHomeCell";

@implementation TangHomeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)configure:(TangPost *)posts
{
    self.post = posts;
    
    UIImageView *imageView = self.tumblrImageView;
    ygweakify(imageView);
    
    NSUInteger hash = posts.thumbnail_url.hash;
    
    self.tumblrImageView.alpha = 0;
    SDWebImageOptions options = SDWebImageLowPriority | SDWebImageAvoidAutoSetImage | SDWebImageRetryFailed | SDWebImageContinueInBackground;
    [self.tumblrImageView sd_setImageWithURL:[NSURL URLWithString:posts.thumbnail_url]
                            placeholderImage:nil
                                     options:options
                                    progress:nil
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       NSUInteger hash2 = hash;
                                       if (image && imageURL.absoluteString.hash == hash2) {
                                           ygstrongify(imageView);
                                           imageView.image = image;
                                           [UIView animateWithDuration:.2f animations:^{
                                               imageView.alpha = 1.f;
                                           }];
                                       }
                                   }];
    
    NSString *avatar = [[TangAvatarManager manager] avatar:posts.blog_name];
    [self.blogAvatarView sd_setImageWithURL:[NSURL URLWithString:avatar]];
    self.blogNameLabel.text = posts.blog_name;
}

- (IBAction)blogNameAction:(id)sender
{
    [SVProgressHUD showInfoWithStatus:self.post.blog_name];
}

- (IBAction)likeAction:(id)sender
{
    [SVProgressHUD showInfoWithStatus:@"Like"];
}

- (IBAction)downloadAction:(id)sender
{
    [SVProgressHUD showInfoWithStatus:@"Download"];
}

- (IBAction)previewAction:(id)sender
{
    [SVProgressHUD showInfoWithStatus:@"Preview"];
}


@end
