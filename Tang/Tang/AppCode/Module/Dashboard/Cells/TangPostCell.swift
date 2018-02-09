//
//  TangPostCell.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangPostCell: UITableViewCell {

    fileprivate(set) var post : TangPost!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ post : TangPost) {
        self.post = post
    }
}
