//
//  ViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/4.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit
import Foundation

class SelfViewController: UIViewController{
    //记录 self.view 的原始 origin.y
    private var originY: CGFloat = 0
    //正在输入的UITextField
    private var editingText: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let aSelector : Selector = #selector(SelfViewController.removeSubview)
        //let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        //self.view.addGestureRecognizer(tapGesture)
        
        if Defaults().get(key: Users_struct().username).elementsEqual("") || Defaults.defaults.bool(forKey: Users_struct().username){
            let login = LoginView.loadFromNib("login")
            login.show()
            self.view.removeFromSuperview()
            self.view.addSubview(login)
            
        }
        else{
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.view.addSubview(identity)
            
        }
    }
}
