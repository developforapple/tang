//
//  TangPostVideoCell.swift
//  Tang
//
//  Created by Tiny on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SDWebImage

class TangPostVideoCell: TangPostCell {

    public static let kTangPostVideoCell = "TangPostVideoCell"
    
    @IBOutlet var tumblrImageView : FLAnimatedImageView!
    @IBOutlet var blogAvatarView : UIImageView!
    @IBOutlet var blogNameLabel : UILabel!
    @IBOutlet var likeBtn : UIButton!
    @IBOutlet var downloadBtn : UIButton!
    @IBOutlet var previewBtn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func configure(_ post: TangPost) {
        super.configure(post)
        
        guard let url = post.thumbnail_url else { return}
        
        let hash = url.hashValue
        
        tumblrImageView.alpha = 0
        let options : SDWebImageOptions = [.lowPriority,.avoidAutoSetImage,.retryFailed,.continueInBackground]
        tumblrImageView.sd_setImage(with: URL.init(string: url),
                                    placeholderImage: nil,
                                    options: options) { [unowned self] (_img, _error, _cachedType, _imageURL) in
                                        let hash2 = hash
                                        if let image = _img, let imageURL = _imageURL, imageURL.hashValue == hash2 {
                                            self.tumblrImageView.image = image
                                            UIView.animate(withDuration: 0.2, animations: {
                                                self.tumblrImageView.alpha = 1
                                            })
                                        }
        }
        
        if let avatar = Avatar.make(post.blog_name) {
            blogAvatarView.sd_setImage(with: URL.init(string: avatar), completed: nil)
        }else{
            blogAvatarView.image = nil
        }
        blogNameLabel.text = post.blog_name
    }
    
    @IBAction func blogNameAction(_ sender : Any) {
        
    }
    
    @IBAction func likeAction(_ sender : Any) {
        
    }
    
    @IBAction func downloadAction(_ sender : Any) {
        
    }
    
    @IBAction func previewAction(_ sender : Any) {
        
    }

}
