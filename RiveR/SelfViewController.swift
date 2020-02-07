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
        print(Defaults().get(key: Users_struct().username).elementsEqual(""))
        // Do any additional setup after loading the view.
        //let aSelector : Selector = #selector(SelfViewController.removeSubview)
        //let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        //self.view.addGestureRecognizer(tapGesture)
        
        if Defaults().get(key: Users_struct().username).elementsEqual("") || Defaults.defaults.bool(forKey: Users_struct().username){
            let login = LoginView.loadFromNib("login")
            login.show()
            self.view.removeFromSuperview()
            print("1\t"+"\(self.view.subviews.count)")
            self.view.addSubview(login)
            print("2\t"+"\(self.view.subviews.count)")
        }
        else{
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.view.addSubview(identity)
            //label.text = Defaults().get(key: Users_struct().username)
        }
    }
    @objc func removeSubview(){
        print("Start remove sibview")
        if let viewWithTag = self.view.viewWithTag(self.view.subviews.count - 1) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }

    
    //键盘弹起
    @objc func keyboardWillAppear(notification: NSNotification) {
        // 获得软键盘的高
        let keyboardinfo = notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey]
        let keyboardheight:CGFloat = (keyboardinfo as AnyObject).cgRectValue.size.height
    
        //计算输入框和软键盘的高度差
        self.originY = self.view.frame.origin.y
        let rect = self.editingText!.convert(self.editingText!.bounds, to: self.view)
        let y = self.view.bounds.height - rect.origin.y - self.editingText!.bounds.height - keyboardheight
        
        //设置中心点偏移
        UIView.animate(withDuration: 0.5) {
            if y < 0 {
                self.view.frame.origin.y = (self.originY + y)
            }
        }
    }
        
    //键盘落下
    @objc func keyboardWillDisappear(notification:NSNotification){
        //软键盘收起的时候恢复原始偏移
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = self.originY
        }
    }
}
