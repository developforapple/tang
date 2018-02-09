//
//  Statistic.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

func YG_BEGIN_PAGE(_ name : String) {
    StatisticUtil.beginLogPage(name)
}

func YG_END_PAGE(_ name : String) {
    StatisticUtil.endLogPage(name)
}

func YG_EVENT(_ eventId : String, _ eventLabel : String? = nil) {
    if let l = eventLabel {
        StatisticUtil.event(eventId, label: l)
    }else{
        StatisticUtil.event(eventId)
    }
}
