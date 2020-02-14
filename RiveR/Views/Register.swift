//
//  Register.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class Register: UIView, NibLoadable, UITextFieldDelegate{

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var account: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var status: UITextField!
    
    var acc : String?
    var unm : String?
    var pwd : String?
    var stu : String?
    
    var roll : RollView!
    
    @IBAction func backToLogin(_ sender: Any) {
        ///注销所有通知
        // 获取用户错误
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().get_error), object: nil)
        
        // 获取用户成功
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().get_success), object: nil)
        let login = LoginView.loadFromNib("login")
        login.show()
        self.removeFromSuperview()
        UIViewController.current()?.view.addSubview(login)
    }
    
    @IBAction func toRegister(_ sender: Any) {
        if account.hasText && password.hasText && status.hasText && username.hasText {
           // 自动登录
            //线程后台--线程登录
            let insert = Thread(target: self, selector: #selector(self.Register), object: nil)
            insert.start()
            let rect = CGRect(x: self.center.x-50, y: self.center.y-50, width: 100, height: 100)
            self.roll = RollView(frame: rect)
            roll.setLabel(text: "正在注册")
            self.roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
            self.addSubview(roll)
        }
        else {
            UIViewController.initAlert(msg: "请输入信息", title: "系统提示", preferredStyle: .alert)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        account.resignFirstResponder()
        password.resignFirstResponder()
        username.resignFirstResponder()
        status.resignFirstResponder()
        //self.endEditing(true)
    }
    
    func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    
    func show(){
        account.placeholder = Placeholder().account
        username.placeholder = Placeholder().username
        password.placeholder = Placeholder().password
        password.isSecureTextEntry = true
        status.placeholder = Placeholder().status
        ///清除所有通知
        /// 注册通知
        // 获取用户错误
        NotificationCenter.default.addObserver(self, selector: #selector(self.systemError), name: Notification.Name(rawValue: Sign().system_error), object: nil)
        
        // 获取用户成功
        NotificationCenter.default.addObserver(self, selector: #selector(self.getSuccess), name: Notification.Name(rawValue: Sign().get_success), object: nil)
        
        self.username.addTarget(self, action: #selector(self.getUsername), for: .editingDidEnd)
        self.account.addTarget(self, action: #selector(self.getAccount), for: .editingDidEnd)
        self.password.addTarget(self, action: #selector(self.getPassword), for: .editingDidEnd)
        self.status.addTarget(self, action: #selector(self.getStatus), for: .editingDidEnd)
    }
    
    //用户注册
    @objc fileprivate func Register(){
        let insert = UserInsert()
        insert.request(account: self.acc!, username: self.unm!, password: self.pwd!, status: self.stu!)
    }
    
    // 用户对象获取成功
    @objc fileprivate func getSuccess(){
        DispatchQueue.main.async {
            self.roll?.removeFromSuperview()
            ///注销所有通知
            // 获取用户错误
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().get_error), object: nil)
            
            // 获取用户成功
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().get_success), object: nil)
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.removeFromSuperview()
            UIViewController.current()?.view.addSubview(identity)
            
        }
    }
       
    // 可能是服务器无响应
    @objc fileprivate func systemError(){
        DispatchQueue.main.async {
            self.roll?.removeFromSuperview()
            UIViewController.initAlert(msg: "无法连接服务器", title: "系统提示", preferredStyle: .alert)
            return
        }
    }
    
    // 获取account
    @objc fileprivate func getAccount(){
        guard self.account.hasText else {
            UIViewController.initAlert(msg: "请输入账号", title: "系统提示", preferredStyle: .alert)
            return
        }
        self.acc = account.text
    }
    
    // 获取password
    @objc fileprivate func getPassword(){
        guard self.password.hasText else {
            UIViewController.initAlert(msg: "请输入密码", title: "系统提示", preferredStyle: .alert)
            return
        }
        self.pwd = self.password.text
    }
    
    // 获取username
    @objc fileprivate func getUsername(){
        guard self.username.hasText else {
            UIViewController.initAlert(msg: "请输入用户名", title: "系统提示", preferredStyle: .alert)
            return
        }
        self.unm = self.username.text
    }
    
    // 获取status
    @objc fileprivate func getStatus(){
        guard self.status.hasText else {
            UIViewController.initAlert(msg: "请输入国籍", title: "系统提示", preferredStyle: .alert)
            return
        }
        self.stu = self.status.text
    }
}
