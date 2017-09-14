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

#import "TangUser.h"

NSString *const kTangOAuthScheme = @"tangoauth";

@interface TangAPI ()<TMOAuthAuthenticatorDelegate,TMNetworkActivityIndicatorManager>
@property (strong, nonatomic) TMURLSession *session;
@property (strong, nonatomic) TMAPIUserCredentials *userCredentials;
@property (strong, nonatomic) TMAPIApplicationCredentials *appCredentials;

@property (strong, nonatomic) TMOAuthAuthenticator *oauthAuthenticator;

@property (strong, nonatomic) TMAPIClient *client;

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
        self.appCredentials = [[TMAPIApplicationCredentials alloc] initWithConsumerKey:kTumblrConsumerKey
                                                                        consumerSecret:kTumblrConsumerSecret];
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
            
            TangUser *user = [TangUser yy_modelWithJSON:response];
            
            NSLog(@"");
            //TODO
        }
    }];
    
    [task resume];
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
        [[UIApplication sharedApplication] openURL:url];
    });
}

@end
