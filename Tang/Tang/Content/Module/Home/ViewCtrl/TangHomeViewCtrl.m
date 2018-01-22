//
//  TangHomeViewCtrl.m
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangHomeViewCtrl.h"
#import "TangHomeCell.h"
#import "TangSession.h"
#import "TangPost.h"
#import "YGRefreshComponent.h"
#import "TangPlayerViewCtrl.h"
#import "TangPlayerTransition.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TangHomeViewCtrl () <UITableViewDelegate,UITableViewDataSource,YGRefreshDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) TASK task;

@property (strong, nonatomic) NSMutableArray<TangPost *> *data;

@end

@implementation TangHomeViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.automaticallyAdjustsScrollViewInsets = self.automaticallyAdjustsScrollViewInsets;
    [self.tableView refreshHeader:YES footer:YES delegate:self];
    
    if (!LOGINED) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kTangSessionUserDidLoginedNotification object:nil]
         subscribeNext:^(NSNotification *x) {
             [self loadDashboard:NO];
         }];
        [SESSION beginLoginProcess];
    }else{
        [self loadDashboard:NO];
    }
}

- (void)loadDashboard:(BOOL)isMore
{
    [self.task cancel];
    [self.tableView resetRefreshing];
    
    NSUInteger offset = self.data.count;
    
    ygweakify(self);
    TASK task =
    [API loadDashboard:isMore?offset:0 completion:^(BOOL suc, NSArray *result) {
        
        if (suc) {
            NSArray *posts = [NSArray yy_modelArrayWithClass:[TangPost class] json:result];
            ygstrongify(self);
            
            if (!self.data) {
                self.data = [NSMutableArray array];
            }
            
            if (!isMore) {
                [self.data removeAllObjects];
            }
            
            [self.data addObjectsFromArray:posts];
            [self.tableView reloadData];
            [self.tableView resetRefreshing];
        }
    }];
    self.task = task;
}

- (void)avatar
{
    
}

- (void)refreshHeaderBeginRefreshing:(UIScrollView *)scrollView
{
    [self loadDashboard:NO];
}

- (void)refreshFooterBeginRefreshing:(UIScrollView *)scrollView
{
    [self loadDashboard:YES];
}

- (void)loginIfNeed
{
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TangHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTangHomeCell forIndexPath:indexPath];
    [cell configure:self.data[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TangPost *post = self.data[indexPath.row];
    float width = post.thumbnail_width;
    float height = post.thumbnail_height;
    
    CGFloat cellHeight = height / width * Device_Width;
    return ceilf(cellHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TangPlayerViewCtrl *vc = [TangPlayerViewCtrl instanceFromStoryboard];
    vc.post = self.data[indexPath.row];
    
    TangPlayerTransition *transition = [TangPlayerTransition transition];
    TangPlayerTransitionContext *context = [TangPlayerTransitionContext new];
    context.focusView = [tableView cellForRowAtIndexPath:indexPath];
    [transition showPlayer:vc fromViewController:self context:context];
}

@end
