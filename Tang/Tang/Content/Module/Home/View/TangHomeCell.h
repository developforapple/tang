//
//  TangHomeCell.h
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TangPost.h"
#import <FLAnimatedImage/FLAnimatedImage.h>

FOUNDATION_EXTERN NSString *const kTangHomeCell;

@interface TangHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *tumblrImageView;

@property (weak, nonatomic) IBOutlet UIImageView *blogAvatarView;
@property (weak, nonatomic) IBOutlet UILabel *blogNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;


@property (strong, nonatomic) TangPost *post;

- (void)configure:(TangPost *)posts;

@end
