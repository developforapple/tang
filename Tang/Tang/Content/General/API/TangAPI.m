//
//  TangAPI.m
//  Tang
//
//  Created by Jay on 2017/9/14.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangAPI.h"
#import <TMTumblrSDK/TMAPIClient.h>
#import <TMTumblrSDK/TMOAuthAuthenticator.h>
#import <TMTumblrSDK/TMURLSession.h>
#import <TMTumblrSDK/TMOAuthAuthenticatorDelegate.h>

#import "TangSession.h"
#import <SafariServices/SafariServices.h>

NSString *const kTangOAuthScheme = @"tangoauth";

@interface TangAPI ()<TMOAuthAuthenticatorDelegate,TMNetworkActivityIndicatorManager>
@property (strong, nonatomic) TMURLSession *session;
@property (strong, nonatomic) TMAPIUserCredentials *userCredentials;
@property (strong, nonatomic) TMAPIApplicationCredentials *appCredentials;

@property (strong, nonatomic) TMOAuthAuthenticator *oauthAuthenticator;

@property (strong, nonatomic) TMAPIClient *client;

@property (strong, nonatomic) SFSafariViewController *oauthBrowser;

@end

@implementation TangAPI

+ (instancetype)instance
{
    static TangAPI *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TangAPI new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.appCredentials = [[TMAPIApplicationCredentials alloc] initWithConsumerKey:kTumblrConsumerKey0
                                                                        consumerSecret:kTumblrConsumerSecret0];
        self.userCredentials = [[TMAPIUserCredentials alloc] initWithToken:ME.token tokenSecret:ME.tokenSecret];
    }
    return self;
}

- (BOOL)handleURL:(NSURL *)url
{
    return [self.oauthAuthenticator handleOpenURL:url];
}

- (TMAPIClient *)client
{
    if (!_client) {
        TMURLSession *session = [[TMURLSession alloc] initWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                     applicationCredentials:self.appCredentials
                                                            userCredentials:self.userCredentials
                                                     networkActivityManager:self
                                                  sessionTaskUpdateDelegate:nil
                                                     sessionMetricsDelegate:nil
                                                         requestTransformer:nil
                                                          additionalHeaders:nil];
        TMRequestFactory *factory = [[TMRequestFactory alloc] init];
        _client = [[TMAPIClient alloc] initWithSession:session requestFactory:factory];
    }
    return _client;
}

#pragma mark - OAuth

- (void)requestOAuth
{
    TMURLSession *session = [[TMURLSession alloc] initWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 applicationCredentials:self.appCredentials
                                                        userCredentials:self.userCredentials
                                                 networkActivityManager:self
                                              sessionTaskUpdateDelegate:nil
                                                 sessionMetricsDelegate:nil
                                                     requestTransformer:nil
                                                      additionalHeaders:nil];
    self.oauthAuthenticator = [[TMOAuthAuthenticator alloc] initWithSession:session
                                                     applicationCredentials:self.appCredentials
                                                                   delegate:self];
    ygweakify(self);
    [self.oauthAuthenticator authenticate:kTangOAuthScheme
                                 callback:^(TMAPIUserCredentials *userCredentials, NSError *error) {
                                     ygstrongify(self);
                                     if (error) {
                                         NSLog(@"OAuth failed : %@",error);
                                     }else{
                                         NSLog(@"OAuth successed ! : %@",userCredentials);
                                         self.userCredentials = userCredentials;
                                         [self fetchUserInfo:userCredentials];
                                     }
                                 }];
}

#pragma mark - UserInfo
- (void)fetchUserInfo:(TMAPIUserCredentials *)userCredentials
{
    ygweakify(self);
    NSURLSessionTask *task =
    [self.client userInfoDataTaskWithCallback:^(NSDictionary *response, NSError *error) {
        ygstrongify(self);
        
        if (error) {
            NSLog(@"Request user info failed : %@",error);
        }else{
            NSLog(@"Request user info successed ! : %@",response);
            RunOnMainQueue(^{
                [self dismissOAuthBrowser];
                
                TangUser *user = [TangUser yy_modelWithJSON:response];
                user.token = userCredentials.token;
                user.tokenSecret = userCredentials.tokenSecret;
                [SESSION logined:user];
            });
        }
    }];
    
    [task resume];
}

- (void)dismissOAuthBrowser
{
    if (self.oauthBrowser && self.oauthBrowser.presentingViewController) {
        [self.oauthBrowser dismissViewControllerAnimated:YES completion:nil];
    }
    self.oauthBrowser = nil;
}

#pragma mark - Delegate
- (void)setNetworkActivityIndicatorVisible:(BOOL)networkActivityIndicatorVisible
{
    RunOnMainQueue(^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:networkActivityIndicatorVisible];
    });
}

- (void)openURLInBrowser:(NSURL *)url
{
    RunOnMainQueue(^{
        
        [self dismissOAuthBrowser];
        
        self.oauthBrowser = [[SFSafariViewController alloc] initWithURL:url];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.oauthBrowser animated:YES completion:nil];
        
    });
}

#pragma mark - Dashboard

- (TASK)loadDashboard:(NSUInteger)offset
           completion:(void(^)(BOOL suc,NSArray *result))completion
{
    NSMutableDictionary *request = [NSMutableDictionary dictionary];
    
    request[@"limit"] = @20;
    request[@"type"] = @"video";
    request[@"offset"] = @(offset);
//    request[@"reblog_info"] = @YES;
//    request[@"notes_info"] = @YES;
    
    NSURLSessionTask *task =
    [self.client dashboardRequest:request
                         callback:^(NSDictionary *response, NSError *error) {
                             if (error) {
                                 NSLog(@"load dashboard failed: %@",error);
                                 if (completion) {
                                     completion(NO,nil);
                                 }
                             }else{
                                 NSLog(@"load dashboard successed");
                                 
                                 NSArray *posts = response[@"posts"];
                                 if (completion) {
                                     completion(YES,posts);
                                 }
                             }
                         }];
    [task resume];
    return task;
}

- (TASK)fetchAvatar:(NSString *)blogName
         completion:(void (^)(BOOL suc,NSString *baseUrl))completion
{
    TASK task =
    [self.client avatarWithBlogName:blogName
                               size:16
                           callback:^(NSData *data, NSURLResponse *response, NSError *error) {
                               
                               if (error) {
                                   
                                   RunOnMainQueue(^{
                                       if (completion) {
                                           completion(NO,nil);
                                       }
                                   });
                                   
                               }else{
                                   
                                   NSURLComponents *components = [NSURLComponents componentsWithURL:response.URL resolvingAgainstBaseURL:NO];
                                   components.fragment = nil;
                                   NSString *url = components.string;
                                   NSString *ext = url.pathExtension;
                                   
                                   NSString *regex = [NSString stringWithFormat:@"_[0-9]+.%@",ext];
                                   NSString *tmp = [NSString stringWithFormat:@"_%%d.%@",ext];
       
                                   url = [url stringByReplacingRegex:regex options:kNilOptions withString:tmp];
                                   
                                   RunOnMainQueue(^{
                                       if (completion) {
                                           completion(YES,url);
                                       }
                                   });
                               }
                           }];
    [task resume];
    return task;
}

@end
