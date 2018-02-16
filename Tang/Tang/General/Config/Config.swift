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

#if DEBUG
    let DEBUG_MODE = true
#else
    let DEBUG_MODE = false
#endif
