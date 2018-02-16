//
//  TMPostType.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/10.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import Foundation

enum TMPostType : String, Codable {
    case text
    case photo
    case quote
    case link
    case chat
    case audio
    case video
    case answer
}
