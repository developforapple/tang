//
//  TangUser.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangUser : Codable {
    
    var name : String?
    var likes : Int = 0
    var following : Int = 0
    var default_post_format : String?
    var blogs : [TangBlog]?
    var token : String?
    var tokenSecret : String?
}
