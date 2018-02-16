//
//  TMPostState.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/10.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import Foundation

enum TMPostState : String, Codable {
    case published
    case queued
    case draft
    case `private`
}
