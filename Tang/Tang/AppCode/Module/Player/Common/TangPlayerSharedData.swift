//
//  TangPlayerSharedData.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/11.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import UIKit

class TangPlayerSharedData: NSObject {
    
    var post : TangVideoPost!
    var info : TangVideoInfo?
    
    var focusImage : UIImage!
    
    required init(_ post : TangVideoPost, image : UIImage) {
        super.init()
        self.post = post
        self.focusImage = image
    }
    
    func getVideoInfo(_ completion : @escaping (TangVideoInfo?)->Void) {
        RunOnGlobal {
            let info = VideoParser.parse(self.post)
            RunOnMain {
                self.info = info
                completion(info)
            }
        }
    }
}
