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

    
    @IBAction func toRegister(_ sender: Any) {
        if username.hasText && account.hasText && password.hasText && status.hasText{
            let acc = account.text
            let unm = username.text
            let pwd = password.text
            let stu = status.text
            // 自动登录
            //线程后台--线程登录
            let group = DispatchGroup()
            let globalQueue = DispatchQueue.global()//创建一个全局队列
            globalQueue.async(group: group, execute: {
                UserInsert().request(account: acc!, username: unm!, password: pwd!, status: stu!)
            })
            Thread.sleep(forTimeInterval: 2)
            group.notify(queue: globalQueue, execute: {
                DispatchQueue.main.async {
                    let identity = Identity.loadFromNib("indentity")
                    identity.show()
                    self.addSubview(identity)
                }
            })
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
        account.placeholder = "请输入账号"
        username.placeholder = "请输入昵称"
        password.placeholder = "请输入密码"
        password.isSecureTextEntry = true
        status.placeholder = "请输入国籍"
    }
    
}
