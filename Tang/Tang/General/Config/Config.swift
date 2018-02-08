//
//  Config.swift
//  Laidian
//
//  Created by Jay on 2018/1/31.
//  Copyright © 2018年 来电科技. All rights reserved.
//

import Foundation


/// 生产环境
let ProductionEnvironment = false

/// 内测版本
let InHouseVersion = false

/// DEBUG模式
let DEBUG_MODE = (ProductionEnvironment || InHouseVersion)

