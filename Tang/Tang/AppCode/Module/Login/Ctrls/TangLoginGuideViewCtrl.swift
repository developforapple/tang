//
//  TangLoginGuideViewCtrl.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import SVProgressHUD

class TangLoginGuideViewCtrl: YGBasePopViewCtrl {

    private var loginNaviCtrl : TangLoginNaviCtrl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func logined() {
        SVProgressHUD.show()
        RunAfter(0.4) {
            SVProgressHUD.showSuccess(withStatus: "登录成功")
            self.dismiss()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "TangLoginNaviCtrlSegueID":
                loginNaviCtrl = segue.destination as! TangLoginNaviCtrl
                loginNaviCtrl.didLogined = {
                    [unowned self] in
                    self.logined()
                }
            default: break
            }
        }
    }
}
