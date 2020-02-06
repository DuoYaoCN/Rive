//
//  MainPageViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/4.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = Defaults.defaults.value(forKey: Users_struct().username) as? String
        // Do any additional setup after loading the view.
        
    }
    // 刷新数据
    @objc func refreshData() {
        //移除老数据
        Label.text = Defaults().get(key: Users_struct().username)
        self.refreshControl.endRefreshing()
    }
}
