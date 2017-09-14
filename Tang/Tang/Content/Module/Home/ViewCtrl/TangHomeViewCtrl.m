//
//  TangHomeViewCtrl.m
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangHomeViewCtrl.h"

@interface TangHomeViewCtrl ()

@end

@implementation TangHomeViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [API requestOAuth];
}

@end
