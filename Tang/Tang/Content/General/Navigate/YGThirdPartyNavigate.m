//
//  YGThirdPartyNavigate.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/7/3.
//  Copyright © 2017年 来电科技 All rights reserved.
//

@import MapKit;

#import "YGThirdPartyNavigate.h"

#if GaodeSDK_Enabled
    #import <AMapFoundationKit/AMapURLSearch.h>
#endif

@implementation YGThirdPartyNavigate

+ (void)navigateTo:(CLLocationCoordinate2D)coordinate name:(NSString *)name view:(UIView *)view
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"开始导航" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YG_EVENT_B(ID_ITEM_NAVI, LABEL_ITEM_NAVI_GAODE_MAP);
        [self navigateTo:coordinate name:name use:YGNavigateKindGaode];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YG_EVENT_B(ID_ITEM_NAVI, LABEL_ITEM_NAVI_BAIDU_MAP);
        [self navigateTo:coordinate name:name use:YGNavigateKindBaidu];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YG_EVENT_B(ID_ITEM_NAVI, LABEL_ITEM_NAVI_APPLE_MAP);
        [self navigateTo:coordinate name:name use:YGNavigateKindApple];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    if (IS_iPad) {
        alert.popoverPresentationController.sourceView = view;
        alert.popoverPresentationController.sourceRect = view.bounds;
        alert.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)navigateTo:(CLLocationCoordinate2D)coordinate name:(NSString *)name use:(YGNavigateKind)kind
{
    switch (kind) {
        case YGNavigateKindGaode:{
            [self navigateUseGaode:coordinate name:name];
        }   break;
        case YGNavigateKindBaidu:{
            [self navigateUseBaidu:coordinate name:name];
        }   break;
        case YGNavigateKindApple:{
            [self navigateUseApple:coordinate name:name];
        }   break;
    }
}

+ (BOOL)canOpenMap:(YGNavigateKind)kind
{
    NSURL *URL;
    switch (kind) {
        case YGNavigateKindGaode:{
            URL = [NSURL URLWithString:@"iosamap://xxxxx"];
        }   break;
        case YGNavigateKindBaidu:{
            URL = [NSURL URLWithString:@"baidumap://xxxxx"];
        }   break;
        case YGNavigateKindApple:{
            URL = [NSURL URLWithString:@"map://"];
        }   break;
    }
    
    return URL ? [[UIApplication sharedApplication] canOpenURL:URL] : NO ;
}

+ (void)navigateUseGaode:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    if (![self canOpenMap:YGNavigateKindGaode]) {
        [UIAlertController confirm:@"设备未安装高德地图" message:@"" cancel:nil redDone:@"App Store" callback:^(BOOL done) {
            if (done) {
                
#if GaodeSDK_Enabled
                [AMapURLSearch getLatestAMapApp];
#else
                NSURL *URL = [NSURL URLWithString:@"https://itunes.apple.com/app/id461703208"];
                [[UIApplication sharedApplication] openURL:URL];
#endif
            }
        }];
        return;
    }
    
    //http://lbs.amap.com/api/amap-mobile/guide/ios/route
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@""];
    components.scheme = @"iosamap";
    components.host = @"path";
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[NSURLQueryItem queryItemWithName:@"sourceApplication" value:AppDisplayName]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"dname" value:name?:@""]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"dlat" value:[@(coordinate.latitude) stringValue]]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"dlon" value:[@(coordinate.longitude) stringValue]]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"dev" value:@"0"]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"t" value:@"3"]];   //0驾车1公交2步行3骑行
    
    components.queryItems = items;
    
    NSURL *URL = [components URL];
    [[UIApplication sharedApplication] openURL:URL];
}

+ (void)navigateUseBaidu:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    if (![self canOpenMap:YGNavigateKindBaidu]) {
        [UIAlertController confirm:@"设备未安装百度地图" message:@"" cancel:nil redDone:@"App Store" callback:^(BOOL done) {
            if (done) {
                NSURL *URL = [NSURL URLWithString:@"https://itunes.apple.com/app/id452186370"];
                [[UIApplication sharedApplication] openURL:URL];
            }
        }];
        return;
    }
    
    //http://lbsyun.baidu.com/index.php?title=uri/api/ios
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@""];
    components.scheme = @"baidumap";
    components.host = @"map";
    components.path = @"/direction";
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[NSURLQueryItem queryItemWithName:@"origin" value:@"我的位置"]];
    if (name) {
        [items addObject:[NSURLQueryItem queryItemWithName:@"destination" value:[NSString stringWithFormat:@"name:%@|latlng:%f,%f",name?:@"",coordinate.latitude,coordinate.longitude]]];
    }else{
        [items addObject:[NSURLQueryItem queryItemWithName:@"destination" value:[NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude]]];
    }
    [items addObject:[NSURLQueryItem queryItemWithName:@"mode" value:@"transit"]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"coord_type" value:@"gcj02"]];
    [items addObject:[NSURLQueryItem queryItemWithName:@"src" value:AppDisplayName]];
    
    components.queryItems = items;
    
    NSURL *URL = [components URL];
    [[UIApplication sharedApplication] openURL:URL];
}

+ (void)navigateUseApple:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    // 会自动提示苹果地图安装
    MKMapItem *location = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *to = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
    to.name = name;
    
    NSString *directionsMode;
    if (iOS10) {
        directionsMode = MKLaunchOptionsDirectionsModeDefault;
    }else if (iOS9){
        directionsMode = MKLaunchOptionsDirectionsModeTransit;
    }else{
        directionsMode = MKLaunchOptionsDirectionsModeWalking;
    }
    
    [MKMapItem openMapsWithItems:@[location,to] launchOptions:@{MKLaunchOptionsDirectionsModeKey:directionsMode,
                                                                MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),
                                                                MKLaunchOptionsShowsTrafficKey:@YES}];
}

@end
