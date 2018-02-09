//
//  TangDashboardViewCtrl.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class TangDashboardViewCtrl: YGBaseViewCtrl {

    private var data : [TangPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        asdf
    }
}

// MARK: - DataSource
extension TangDashboardViewCtrl : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
}

// MARK: - Delegate
extension TangDashboardViewCtrl : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = data[indexPath.row]
        let width = post.thumbnail_width ?? Device_Width
        let height = post.thumbnail_height ?? 100.0
        let cellHeight = height / width * Device_Width
        return ceil(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
