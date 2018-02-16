//
//  TangPhoto.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/10.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import UIKit

class TangPhotos : Codable {
    var caption     : String?           // user supplied caption for the individual photo (Photosets only)
    var alt_sizes   : [TangPhoto] = []  // alternate photo sizes, each with:
}

class TangPhoto : Codable {
    var width       : Int = Int(Screen_Width)   // width of the photo, in pixels
    var height      : Int = Int(100)            // height of the photo, in pixels
    var url         : String!                   // Location of the photo file (either a JPG, GIF, or PNG)
}
