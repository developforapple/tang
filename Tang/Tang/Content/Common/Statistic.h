//
//  Statistic.h
//
//  Created by bo wang on 2016/11/25.
//  Copyright © 2016年 WangBo. All rights reserved.
//

#ifndef Statistic_h
#define Statistic_h

// 首页地图
#define ID_HOME_SCAN          //首页扫码
#define ID_HOME_FOCUS_ME      //焦距我
#define ID_HOME_NEARBY        //点击附近列表
#define ID_HOME_SEARCH        //点击搜索按钮
#define ID_HOME_FOCUS_ITEM    //点击网点图标
#define ID_HOME_ITEM_DETAIL   //点击进入网点详情
#define ID_HOME_USER          //显示抽屉菜单

// 扫码
#define ID_SCAN                    //扫描到二维码
#define LABEL_SCAN_TERMINAL        //来电终端
#define LABEL_SCAN_ZMB             //桌面宝
#define LABEL_SCAN_COUPON          //优惠券
#define LABEL_SCAN_RETURN          //回守仓
#define LABEL_SCAN_LAIDIAN         //CDT://
#define LABEL_SCAN_URL             //网页
#define LABEL_SCAN_UNKNOWN         //其他类型

// 网点详情
#define ID_ITEM_NAVI                    //点击导航
#define LABEL_ITEM_NAVI_APPLE_MAP       //使用apple导航
#define LABEL_ITEM_NAVI_GAODE_MAP       //使用高德导航
#define LABEL_ITEM_NAVI_BAIDU_MAP       //使用百度导航
#define ID_ITEM_CALL              //客服电话
#define ID_ITEM_SCAN              //网点详情扫码

// 首页抽屉页
#define ID_MINE_TAP                  //抽屉菜单点击项
#define LABEL_MINE_AVATER            //点击头像
#define LABEL_MINE_VIP               //点击VIP图标
#define LABEL_MINE_WALLET            //点击“我的钱包”
#define LABEL_MINE_COUPON            //点击“我的优惠”
#define LABEL_MINE_ORDER             //点击“我的订单”
#define LABEL_MINE_HELP              //点击“帮助中心”
#define LABEL_MINE_SETTING           //点击“设置”

// 钱包
#define ID_WALLET_RECHARGE                    //充值
#define ID_WALLET_WITHDRAW                    //提现
#define ID_WALLET_WITHDRAW_TAP                //点击提现按钮
#define ID_WALLET_WITHDRAW_BEGIN              //确认提现
#define ID_WALLET_RECHARGE_AMOUNT             //充值金额选择
#define ID_WALLET_RECHARGE_PLATFORM           //充值平台选择
#define LABEL_WALLET_RECHARGE_AMOUNT_1       //充值金额10元
#define LABEL_WALLET_RECHARGE_AMOUNT_2       //充值金额50元
#define LABEL_WALLET_RECHARGE_AMOUNT_3      //充值金额100元
#define LABEL_WALLET_RECHARGE_PLATFORM_WECHAT //充值平台微信
#define LABEL_WALLET_RECHARGE_PLATFORM_ALIPAY //充值平台支付宝

// 优惠
#define ID_COUPON_SCAN      //优惠页扫码
#define ID_COUPON_RULE      //规则

// 订单
#define ID_ORDER_HELP       //帮助中心

// 帮助中心
#define ID_HELP_TYPE
#define LABEL_HELP_TYPE_1
#define LABEL_HELP_TYPE_2
#define LABEL_HELP_TYPE_3
#define ID_HELP_CALL        //客服电话

// 设置


// 租借
#define ID_RENT_TAP_UNIT                //点击租借页某个单元
#define ID_RENT_TAP_CDB_DONE            //点击充电宝类型，并且确定
#define LABEL_RENT_TAP_CDB_TYPE1        //苹果线充电宝
#define LABEL_RENT_TAP_CDB_TYPE2        //安卓线充电宝
#define LABEL_RENT_TAP_CDB_TYPE3        //typec线充电宝
#define LABEL_RENT_TAP_CDB_TYPE4        //不带线充电宝
#define LABEL_RENT_TAP_LINE             //购线
#define LABEL_RENT_TAP_LINE_APPLE       //苹果线
#define LABEL_RENT_TAP_LINE_ANDROID     //安卓线
#define LABEL_RENT_TAP_LINE_TYPEC       //typec线
#define ID_RENT_TIMEOUT                 //在租借页发生了超时

// 购线
#define ID_LINE_COUPON                  //优惠券页
#define ID_LINE_COUPON_CHARGE           //更换优惠券
#define ID_LINE_BUY                     //提交购线

// 桌面宝
#define ID_ZMB_HELP                     //使用帮助
#define ID_ZMB_RESCAN                   //重新获取密码
#define ID_ZMB_REPORT                   //充电遇到问题
#define LABEL_ZMB_REPORT_1
#define LABEL_ZMB_REPORT_2

#endif /* Statistic_h */
