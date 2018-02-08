//
//  YGIPAddressHelper.h
//  CDT
//
//  Created by WangBo (developforapple@163.com) on 2017/9/7.
//  Copyright © 2017年 来电科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "code":0,
//    "data":{
//        "country":"中国",
//        "country_id":"CN",
//        "area":"华南",
//        "area_id":"800000",
//        "region":"广东省",
//        "region_id":"440000",
//        "city":"深圳市",
//        "city_id":"440300",
//        "county":"",
//        "county_id":"-1",
//        "isp":"电信",
//        "isp_id":"100017",
//        "ip":"119.139.199.106"
//    }
//}

@interface YGIPAddress : NSObject <NSCopying,NSCoding>
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *country_id;
@property (copy, nonatomic) NSString *area;
@property (copy, nonatomic) NSString *area_id;
@property (copy, nonatomic) NSString *region;
@property (copy, nonatomic) NSString *region_id;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *city_id;
@property (copy, nonatomic) NSString *county;
@property (copy, nonatomic) NSString *county_id;
@property (copy, nonatomic) NSString *isp;
@property (copy, nonatomic) NSString *isp_id;
@property (copy, nonatomic) NSString *ip;
- (NSString *)addressString;
@end

@interface YGIPAddressHelper : NSObject

+ (void)update;
+ (void)update:(void (^)(YGIPAddress *ipaddress))completion;

+ (NSString *)ip;
+ (NSString *)city;
+ (YGIPAddress *)ipaddress;

@end
