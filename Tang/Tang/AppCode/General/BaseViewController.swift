//
//  BaseViewController.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if navigationController?.viewControllers.first != self {
            leftNaviBarItem(templateImage: "icon_back_dark")
        }
    }
    
    deinit {
        print( NSStringFromClass(type(of: self)) + "释放")
    }
    
    func setTitle(image named : String) {
        setTitle(image: UIImage.init(named: named))
    }
    
    func setTitle(image : UIImage?) {
        if let img = image {
            let imageView = UIImageView.init(image: img)
            imageView.bounds = CGRect.init(x: 0, y: 0, width: img.size.width, height: img.size.height)
            imageView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imageView
        }else{
            self.navigationItem.titleView = nil
        }
    }
}

// MARK: - LeftBarButtonItem
extension BaseViewController {
    func leftNaviBarItem(image named : String) {
        if let image = UIImage.init(named: named) {
            leftNaviBarItem(image: image)
        }
    }
    
    func leftNaviBarItem(templateImage named : String) {
        if let image = UIImage.init(named: named)?.withRenderingMode(.alwaysTemplate) {
            leftNaviBarItem(image: image)
        }
    }
    
    func leftNaviBarItem(text : String) {
        let item = UIBarButtonItem.init(title: text,
                                        style: .plain,
                                        target: self,
                                        action: #selector(doLeftNaviBarItemAction))
        self.navigationItem.leftBarButtonItem = item
    }
    
    func leftNaviBarItem(image : UIImage) {
        let item = UIBarButtonItem.init(image: image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(doLeftNaviBarItemAction))
        self.navigationItem.leftBarButtonItem = item
    }
    
    @objc func doLeftNaviBarItemAction() {
        if navigationController?.viewControllers.first == self &&
            navigationController?.presentingViewController != nil{
            navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    func noLeftNaviBarItem() {
        self.navigationItem.leftBarButtonItem = nil
    }
}

// MARK: - RightNaviBarButtoItem
extension BaseViewController {
    func rightNaviBarItem(image named : String) {
        if let image = UIImage.init(named: named) {
            rightNaviBarItem(image: image)
        }
    }
    
    func rightNaviBarItem(templateImage named : String) {
        if let image = UIImage.init(named: named)?.withRenderingMode(.alwaysTemplate) {
            rightNaviBarItem(image: image)
        }
    }
    
    func rightNaviBarItem(text : String) {
        let item = UIBarButtonItem.init(title: text,
                                        style: .plain,
                                        target: self,
                                        action: #selector(doRightNaviBarItemAction))
        self.navigationItem.rightBarButtonItem = item
    }
    
    func rightNaviBarItem(image : UIImage) {
        let item = UIBarButtonItem.init(image: image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(doRightNaviBarItemAction))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func doRightNaviBarItemAction() {
        
    }
    
    func noRightNaviBarItem() {
        self.navigationItem.rightBarButtonItems = nil
    }
}
