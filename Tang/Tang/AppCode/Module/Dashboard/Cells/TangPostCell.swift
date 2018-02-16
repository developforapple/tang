//
//  TangPostCell.swift
//  Tang
//
//  Created by Tiny on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangPostCell <T : TangPost> : UITableViewCell {

    fileprivate(set) var post : T!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ post : T) {
        self.post = post
    }
}
