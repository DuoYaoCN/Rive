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
            var roll : RollView!
            let rect = CGRect(x: self.center.x-50, y: self.center.y-50, width: 100, height: 100)
            roll = RollView(frame: rect)
            roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
            self.addSubview(roll)
            let group = DispatchGroup()
            let globalQueue = DispatchQueue.global()//创建一个全局队列
            let insert = UserInsert()
            globalQueue.async(group: group, execute: {
                insert.request(account: acc!, username: unm!, password: pwd!, status: stu!)
            })
            group.notify(queue: globalQueue, execute: {
                Thread.sleep(forTimeInterval: 2)
                DispatchQueue.main.async {
                    if insert.error == nil{
                        let identity = Identity.loadFromNib("indentity")
                        identity.show()
                        roll.removeFromSuperview()
                        self.addSubview(identity)
                    }
                    else{
                        print("error")
                    }
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
        account.placeholder = Placeholder().account
        username.placeholder = Placeholder().username
        password.placeholder = Placeholder().password
        password.isSecureTextEntry = true
        status.placeholder = Placeholder().status
    }
    
}
