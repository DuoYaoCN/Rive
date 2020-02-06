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
    
    @IBAction func toLogin(_ sender: Any) {
        let verify = UserVerify()
        let get = UserGet()
        if account.hasText && password.hasText{
            let acc = account.text
            let pwd = password.text
            //线程后台--线程登录
            let group = DispatchGroup()
            let globalQueue = DispatchQueue.global()//创建一个全局队列
            globalQueue.async(group: group, execute: {
                verify.request(account: acc!, password: pwd!)
            })
            globalQueue.async(group: group, execute: {
                get.request(account: acc!)
            })
            Thread.sleep(forTimeInterval: 2)
            group.notify(queue: globalQueue, execute: {
                //检测到所有的任务都执行完了，我们可以做一个通知或者说UI的处理
                DispatchQueue.main.async {
                    let identity = Identity.loadFromNib("indentity")
                    identity.show()
                    self.addSubview(identity)
                }
            })
        }
        else{
            return
        }
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
        account.placeholder = "请输入账号"
        password.placeholder = "请输入密码"
        password.isSecureTextEntry = true
    }
    
    func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}