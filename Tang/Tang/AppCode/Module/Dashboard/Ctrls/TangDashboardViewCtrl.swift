//
//  TangDashboardViewCtrl.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import ReactiveObjC

class TangDashboardViewCtrl: YGBaseViewCtrl {

    @IBOutlet var tableview : UITableView!
    
    private var task : API.TASK?
    private var data : [TangPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.automaticallyAdjustsScrollViewInsets = automaticallyAdjustsScrollViewInsets
        setRefreshComponent();
        
        if !UserSession.session.valid {
            let signal = NotificationCenter.default.rac_addObserver(forName: kTangSessionUserDidLoginedNotification.rawValue, object: nil)
            signal.subscribeNext({ (x) in
                self.loadDashboard(false)
            })
            UserSession.session.beginLoginProcess()
        }else{
            loadDashboard(false)
        }
    }
    
    private func loadDashboard(_ more : Bool) {
        task?.cancel()
        tableview.resetRefreshing()
        
        let aTask = API.instance.dashboard(more ? data.count : 0) { [unowned self](suc, resp) in
            guard suc else {return}
            guard let result = resp, JSONSerialization.isValidJSONObject(result) else {return}
            guard let data = try? JSONSerialization.data(withJSONObject: result, options: .prettyPrinted) else {return}
            guard let posts = [TangPost].fromJson(data) else {return}
            
            if !more {
                self.data = posts
            }else{
                self.data.append(contentsOf: posts)
            }
            
            self.tableview.reloadData()
            self.tableview.resetRefreshing()
        }
        self.task = aTask
    }
}

extension TangDashboardViewCtrl : YGRefreshDelegate {
    private func setRefreshComponent(){
        tableview.refreshHeader(true, footer: true, delegate: self)
    }
    
    func refreshHeaderBeginRefreshing(_ scrollView: UIScrollView!) {
        loadDashboard(false)
    }
    
    func refreshFooterBeginRefreshing(_ scrollView: UIScrollView!) {
        loadDashboard(true)
    }
}

// MARK: - DataSource
extension TangDashboardViewCtrl : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TangPostVideoCell.kTangPostVideoCell, for: indexPath) as! TangPostVideoCell
        cell.configure(data[indexPath.row])
        return cell;
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
        tableView.deselectRow(at: indexPath, animated: true)
        
//        TangPlayerViewCtrl *vc = [TangPlayerViewCtrl instanceFromStoryboard];
//        vc.post = self.data[indexPath.row];
//
//        TangPlayerTransition *transition = [TangPlayerTransition transition];
//        TangPlayerTransitionContext *context = [TangPlayerTransitionContext new];
//        context.focusView = [tableView cellForRowAtIndexPath:indexPath];
//        [transition showPlayer:vc fromViewController:self context:context];
    }
}
