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
            guard let response = resp, suc else {return}
            
            let posts = TangPost.adapter(from: response)
            
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
        let post = data[indexPath.row]
        let cell : UITableViewCell!
        switch post.type {
        case .video:
            let aCell = tableView.dequeueReusableCell(withIdentifier: TangPostVideoCell.kTangPostVideoCell, for: indexPath) as! TangPostVideoCell
            aCell.configure(post as! TangVideoPost)
            cell = aCell
        default: cell = UITableViewCell.init()
        }
        return cell
    }
}

// MARK: - Delegate
extension TangDashboardViewCtrl : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = data[indexPath.row]
        var height : CGFloat = 100.0
        switch post.type {
        case .video:
            let videoPost = post as! TangVideoPost
            let cellHeight = CGFloat(videoPost.thumbnail_height) / CGFloat(videoPost.thumbnail_width) * Device_Width
            height = ceil(cellHeight)
        default:break
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let post = data[indexPath.row]
        
        switch post.type {
        case .video:
            let context = TangTransitionContext()
            context.focusView = tableView.cellForRow(at: indexPath)
            let vc = TangPlayerViewCtrl.instanceFromStoryboard()
            vc.data = TangPlayerSharedData.init(post as! TangVideoPost, image: context.focusImage)
            TangPlayerTransition.instance.show(vc, from: self, context: context)
        default:
            break
        }
    }
}
