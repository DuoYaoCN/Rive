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
    
    
    @IBAction func toLogin(_ sender: Any) {
        let verify = UserVerify()
        //线程后台--线程登录
        var roll : RollView!
        let rect = CGRect(x: self.center.x-50, y: self.center.y-50, width: 100, height: 100)
        roll = RollView(frame: rect)
        roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
        self.addSubview(roll)
        let group = DispatchGroup()
        let globalQueue = DispatchQueue.global()//创建一个全局队列
        globalQueue.async(group: group, execute: {
            verify.request(account: self.account_text!, password: self.password_text!)
        })
        group.notify(queue: globalQueue, execute: {
            //检测到所有的任务都执行完了，我们可以做一个通知或者说UI的处理
            Thread.sleep(forTimeInterval: 2)
            if verify.result == nil{
                Thread.sleep(forTimeInterval: 5)
                DispatchQueue.main.async {
                    if verify.result == nil{
                        let identity = Identity.loadFromNib("indentity")
                        identity.show()
                        roll.removeFromSuperview()
                        self.removeFromSuperview()
                        UIViewController.current()?.view.addSubview(identity)
                    }
                    else{
                        print("error")
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    let identity = Identity.loadFromNib("indentity")
                    identity.show()
                    roll.removeFromSuperview()
                    self.removeFromSuperview()
                    UIViewController.current()?.view.addSubview(identity)

                }
            }
        })
             
    }
        
    @IBAction func toRegister(_ sender: Any) {
        let register = Register().loadFromNib("Register")
        register.show()
        self.addSubview(register)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        account.resignFirstResponder()
        password.resignFirstResponder()
        //或者 self.view?.endEditing(true)
    }
    
    func show(){
        account.placeholder = Placeholder().account
        password.placeholder = Placeholder().password
        self.account.addTarget(self, action: #selector(getAccount), for: .editingDidEnd)
        self.password.addTarget(self, action: #selector(getPassword), for: .editingDidEnd)
        password.isSecureTextEntry = true
    }
    
    @objc func getAccount(){
        guard self.account.hasText else {
            let alertController = UIAlertController(title: "系统提示",
                            message: "请输入账号", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            UIViewController.current()?.present(alertController, animated: true, completion: nil)
            return
        }
        self.account_text = account.text
    }
    
    @objc func getPassword(){
        guard self.password.hasText else {
            let alertController = UIAlertController(title: "系统提示",
                            message: "请输入密码", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            UIViewController.current()?.present(alertController, animated: true, completion: nil)
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
