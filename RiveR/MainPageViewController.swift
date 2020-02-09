//
//  MainPageViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/4.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Label.text = Defaults.defaults.value(forKey: Users_struct().username) as? String
        // Do any additional setup after loading the view.
        if !Defaults().get(key: Users_struct().username).elementsEqual(""){
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.view.removeFromSuperview()
            self.view.addSubview(identity)
        }
    }
}
