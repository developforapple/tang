//
//  TangPreviewView.swift
//  Tang
//
//  Created by wwwbbat on 2018/2/11.
//  Copyright © 2018年 Tiny. All rights reserved.
//

import UIKit

class TangPreviewView: UIView {

    @IBOutlet weak var imageView : UIImageView!

    func show(_ image : UIImage) {
        self.imageView.image = image
    }
}
