//
//  Network.swift
//  Laidian
//
//  Created by Tiny on 2018/1/31.
//  Copyright © tiny. All rights reserved.
//

import Foundation

let kAppDomain =    ProductionEnvironment ?
                    "imlaidian.com" :
                    "imlaidian.com"
let kAppHost =      ProductionEnvironment ?
                    "mobile-api.imlaidian.com" :
                    "mobile-api-test.imlaidian.com"
let kZMBHost =      ProductionEnvironment ?
                    "zmb-api.imlaidian.com" :
                    "zmb-api-test.imlaidian.com"
let kAPIURL =       ProductionEnvironment ?
                    "https://mobile-api.imlaidian.com" :
                    "https://mobile-api-test.imlaidian.com"
let kZMBAPIURL =    ProductionEnvironment ?
                    "https://zmb-api.imlaidian.com" :
                    "https://zmb-api-test.imlaidian.com"
let kAppWechatHost = ProductionEnvironment ?
                    "wx.imlaidian.com" :
                    "wx.imlaidian.com"

/// 服务协议
let kAppUsageAgreement = "https://wx.imlaidian.com/share/usageAgreement.html"

/// 充值协议
let kAppRechargeAgreement = "https://wx.imlaidian.com/share/rechargeAgreement.html"

/// 押金说明
let kAppDespoitGuide = ""

/// 帮助中心
let kAppHelpCenter = "https://wx.imlaidian.com/share/helpCenter.html"

/// 提现帮助
let kAppWithdrawHelp = "https://mp.weixin.qq.com/s?idx=1&sn=4de3a87205f52cce621d0009bf591e07&__biz=MzA4MTI0OTA5NA==&mid=401284710"

/// 商务
let kAppBusiness = "https://utility.imlaidian.com/BusinessCorporation"

/// 桌面宝帮助
let kAppZMBHelp = "https://wx.imlaidian.com/zhuomianbao/help.html"

/// 优惠券使用规则
let kAppCouponRule = "https://wx.imlaidian.com/share/helpCenter.html"
