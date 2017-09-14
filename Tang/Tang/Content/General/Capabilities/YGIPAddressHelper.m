//
//  YGIPAddressHelper.m
//  CDT
//
//  Created by Jay on 2017/9/7.
//  Copyright © 2017年 来电科技. All rights reserved.
//

#import "YGIPAddressHelper.h"

@implementation YGIPAddress
YYModelDefaultCode
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
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"]];
        NSDictionary *dic = data ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] : nil;
        if ([dic isKindOfClass:NSDictionary.class]) {
            ipaddress = [YGIPAddress yy_modelWithJSON:dic[@"data"]];
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
