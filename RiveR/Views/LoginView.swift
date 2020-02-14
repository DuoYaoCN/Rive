//
//  LoginView.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class LoginView: UIView, NibLoadable, UITextFieldDelegate{
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var account: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var register: UIButton!
    
    var account_text : String?
    var password_text : String?
    var roll : RollView!
       
    
    @IBAction func toLogin(_ sender: Any) {
        if account.hasText && password.hasText {
            //线程后台--线程登录
            var login_ : Thread?
            login_ = Thread(target: self, selector: #selector(LoginView.userLogin), object: nil)
            login_?.start()
            //主线程绘制loding动画
            let rect = CGRect(x: self.center.x-50, y: self.center.y-50, width: 100, height: 100)
            roll = RollView(frame: rect)
            roll.setLabel(text: String("正在验证"))
            roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
            self.addSubview(roll!)
        }
        else {
            UIViewController.initAlert(msg: "请输入用户名或密码", title: "系统提示", preferredStyle: .alert)
        }
    }
        
    @IBAction func toRegister(_ sender: Any) {
        ///注销所有通知
        // 系统错误
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
        
        // 验证成功
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().verify_success), object: nil)
        
        // 用户名或密码错误
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().verify_error), object: nil)
        
        // 获取用户错误
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().get_error), object: nil)
        
        // 获取用户成功
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().get_success), object: nil)
        
        let register = Register.loadFromNib("Register")
        register.show()
        self.removeFromSuperview()
        UIViewController.current()?.view.addSubview(register)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        account.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func show(){
        account.placeholder = Placeholder().account
        password.placeholder = Placeholder().password
        ///注册子线程通知
        // 系统错误
        NotificationCenter.default.addObserver(self, selector: #selector(self.systemError), name: Notification.Name(rawValue: Sign().system_error), object: nil)
        
        // 验证成功
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyUseerSuccess), name: Notification.Name(rawValue: Sign().verify_success), object: nil)
        
        // 用户名或密码错误
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyUseerError), name: Notification.Name(rawValue: Sign().verify_error), object: nil)
        
        // 获取用户错误
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyUseerError), name: Notification.Name(rawValue: Sign().get_error), object: nil)
        
        // 获取用户成功
        NotificationCenter.default.addObserver(self, selector: #selector(self.getSuccess), name: Notification.Name(rawValue: Sign().get_success), object: nil)
        
        self.account.addTarget(self, action: #selector(getAccount), for: .editingDidEnd)
        self.password.addTarget(self, action: #selector(getPassword), for: .editingDidEnd)
        password.isSecureTextEntry = true
    }
    
    // 用户登录响应
    @objc fileprivate func userLogin(){
        let verify = UserVerify()
        verify.request(account: account_text!, password: password_text!)
        Thread.exit()
    }

    // 用户验证成功响应
    @objc fileprivate func verifyUseerSuccess(){
        DispatchQueue.main.async {
            self.roll?.removeFromSuperview()
            self.roll.setLabel(text: String("正在登录"))
            self.addSubview(self.roll)
            var get_ : Thread?
            get_ = Thread(target: self, selector: #selector(LoginView.userGet), object: nil)
            get_?.start()
        }
    }
    
    // 用户验证成功后进行获取用户对象
    @objc fileprivate func userGet(){
        let get = UserGet()
        get.request(account: self.account_text!)
    }
    
    // 用户对象获取成功
    @objc fileprivate func getSuccess(){
        DispatchQueue.main.async {
            self.roll?.removeFromSuperview()
            ///注销所有通知
            // 系统错误
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
            
            // 验证成功
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().verify_success), object: nil)
            
            // 用户名或密码错误
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().verify_error), object: nil)
            
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
    
    // 用户名或者密码错误
    @objc fileprivate func verifyUseerError(){
        DispatchQueue.main.async {
            self.roll?.removeFromSuperview()
            UIViewController.initAlert(msg: "用户名或密码错误", title: "系统提示", preferredStyle: .alert)
            return
        }
    }
    
    // account对话框输入内容响应
    @objc func getAccount(){
        guard self.account.hasText else {
            UIViewController.initAlert(msg: "请输入账号", title: "系统提示", preferredStyle: .alert)
            return
        }
        self.account_text = account.text
    }
    
    // password对话框输入内容响应
    @objc func getPassword(){
        guard self.password.hasText else {
            UIViewController.initAlert(msg: "请输入密码", title: "系统提示", preferredStyle: .alert)
            return
        }
        self.password_text = password.text
    }
    
    func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
