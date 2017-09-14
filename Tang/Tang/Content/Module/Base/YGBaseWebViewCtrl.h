//
//  YGBaseWebViewCtrl.h
//
//  Created by WangBo (developforapple@163.com) on 2017/4/7.
//  Copyright © 2017年 WangBo. All rights reserved.
//

#import "YGBaseViewCtrl.h"
@import WebKit;

@interface YGBaseWebViewCtrl : YGBaseViewCtrl

+ (void)addInternalHost:(NSString *)host;

@property (strong, readonly, nonatomic) WKWebView *webView;

@property (copy, nonatomic) NSString *baseUrl;

// 是否拒绝外部的URL。默认为YES
@property (assign, nonatomic) BOOL refuseExternalHost;

+ (instancetype)webViewCtrlWithURL:(NSString *)URL;

@property (assign, nonatomic) BOOL refreshControlEnabled;

@end
