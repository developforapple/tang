//
//  Config.swift
//  Laidian
//
//  Created by Tiny on 2018/1/31.
//  Copyright © tiny. All rights reserved.
//

import Foundation


/// 生产环境
let ProductionEnvironment = false

/// 内测版本
let InHouseVersion = false

/// DEBUG模式
let DEBUG_MODE = (ProductionEnvironment || InHouseVersion)

