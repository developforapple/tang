//
//  TangLoginNaviCtrl.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangLoginNaviCtrl: YGBaseNaviCtrl {
    
    var didLogined : (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewCtrl?.didLogined = {
            [unowned self] in
            if let block = self.didLogined {
                block()
            }
        }
    }

    private var loginViewCtrl : TangLoginViewCtrl? {
        get {
            if let vc = viewControllers.first as? TangLoginViewCtrl {
                return vc
            }
            assert(false, "视图层级错误")
            return nil
        }
    }
    

}
