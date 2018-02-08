//
//  YGIPAddressHelper.m
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/9/7.
//  Copyright © 2017年 来电科技. All rights reserved.
//

#import "YGIPAddressHelper.h"

@implementation YGIPAddress
YYModelDefaultCode

- (NSString *)addressString
{
    if (self.city.length > 0) {
        return self.city;
    }
    NSMutableString *string = [NSMutableString string];
    if (self.country.length > 0) {
        [string appendString:self.area];
    }
    if (self.region.length > 0) {
        [string appendString:self.region];
    }
    return string;
}

@end

static NSString *kIPAddressSaveKey = @"cdt_ip_address_key";

@implementation YGIPAddressHelper

+ (void)update
{
    [self update:NULL];
}

+ (void)update:(void (^)(YGIPAddress *ipaddress))completion
{
    RunOnGlobalQueue(^{
        YGIPAddress *ipaddress;
        NSURL *URL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        NSDictionary *dic = data ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] : nil;
        NSLog(@"ip地址信息：%@",dic);
        if ([dic isKindOfClass:NSDictionary.class]) {
            id respData = dic[@"data"];
            ipaddress = [YGIPAddress yy_modelWithJSON:respData];
        }
        if (ipaddress) {
            [self save:ipaddress];
        }else{
            ipaddress = [self ipaddress];
        }
        RunOnMainQueue(^{
            if (completion) {
                completion(ipaddress);
            }
        });
    });
}

+ (NSString *)ip
{
    return [self ipaddress].ip;
}

+ (NSString *)city
{
    return [self ipaddress].city;
}

+ (void)save:(YGIPAddress *)ipaddress
{
    id object = [ipaddress yy_modelToJSONData];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:kIPAddressSaveKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (YGIPAddress *)ipaddress
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kIPAddressSaveKey];
    YGIPAddress *ipaddress = [YGIPAddress yy_modelWithJSON:data];
    return ipaddress;
}

@end
