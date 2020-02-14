//
//  AMViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/6.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class AMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    var dataArray: Array<String>?
    var subTitle : [String] = []
    
    var roll : RollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "account")
        self.dataArray = ["标识", "账号","昵称", "密码", "国籍"]
        subTitle = []
        for i in 0...self.dataArray!.count{
            //subTitle.append(Defaults().get(key: Users_struct().get(index: i)))
            switch i {
            case 0: subTitle.append(Defaults().get(key: Users_struct().userId))
            case 1: subTitle.append(Defaults().get(key: Users_struct().userAccount))
            case 2: subTitle.append(Defaults().get(key: Users_struct().username))
            case 3: subTitle.append(Defaults().get(key: Users_struct().userpasswd))
            case 4: subTitle.append(Defaults().get(key: Users_struct().userStatus))
            default:
                break
            }
        }
        self.tableView.reloadData()
        //设置代理和数据源
        tableView.delegate = self
        tableView.dataSource = self
        
        /// 注册通知组件
        // 成功
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSuccess), name: Notification.Name(rawValue: Sign().update_success), object: nil)
        // 失败
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateError), name: Notification.Name(rawValue: Sign().update_error), object: nil)
        
        // 服务器出现问题
        NotificationCenter.default.addObserver(self, selector: #selector(self.sysError), name: Notification.Name(rawValue: Sign().system_error), object: nil)
    }
    
    @objc func updateSuccess(){
        DispatchQueue.main.async {
            self.roll.removeFromSuperview()
            
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.navigationController?.popViewController(animated: true)
            UIViewController.current()?.viewDidLoad()
            UIViewController.current()?.view.addSubview(identity)
            
            ///删除注册组件
            // 成功
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().update_success), object: nil)
            // 失败
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().update_error), object: nil)
            
            // 服务器出现问题
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
            
            UIViewController.initAlert(msg: "更新信息成功", title: "系统通知", preferredStyle: .alert)
        }
    }
    
    @objc func updateError(){
        DispatchQueue.main.async {
            self.roll.removeFromSuperview()
            
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.navigationController?.popViewController(animated: true)
            UIViewController.current()?.viewDidLoad()
            UIViewController.current()?.view.addSubview(identity)
            
            ///删除注册组件
            // 成功
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().update_success), object: nil)
            // 失败
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().update_error), object: nil)
            
            // 服务器出现问题
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
            
            UIViewController.initAlert(msg: "更新失败", title: "系统通知", preferredStyle: .alert)
        }
    }
    
    @objc func sysError(){
        DispatchQueue.main.async {
            self.roll.removeFromSuperview()
            
            let identity = Identity.loadFromNib("indentity")
            identity.show()
            self.navigationController?.popViewController(animated: true)
            UIViewController.current()?.viewDidLoad()
            UIViewController.current()?.view.addSubview(identity)
            
            ///删除注册组件
            // 成功
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().update_success), object: nil)
            // 失败
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().update_error), object: nil)
            
            // 服务器出现问题
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
            
            UIViewController.initAlert(msg: "无法连接到服务器", title: "系统通知", preferredStyle: .alert)
        }
    }
    
    @objc func userUpdate(){
        DispatchQueue.main.async {
            let user = Users()
            user.set_id(id: Defaults().get(key: Users_struct().userId))
            user.set_username(username: Defaults().get(key: Users_struct().username))
            user.set_account(account: Defaults().get(key: Users_struct().userAccount))
            user.set_password(password: Defaults().get(key: Users_struct().userpasswd))
            user.set_status(status: Defaults().get(key: Users_struct().userStatus))
            let update = UserUpdate()
            
            update.request(user: user)
        }
    }
    
    /**
        The functions blow is controller of TableView
     */
    
    //画几个tablecell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray!.count
    }
    
    //索引栏标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    //设置每个cell的高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    //返回一个cell对象
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "account") as! AccountTableViewCell
        cell.title.text = dataArray![indexPath.section]
        cell.userdata.text = subTitle[indexPath.section]
        cell.userdata.adjustsFontSizeToFitWidth = true
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        return cell
    }

    //监听cell是否被点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转
        if indexPath.section == 0{
            return
        }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "contain")
        ContainViewController.data = subTitle[indexPath.section]
        ContainViewController.index = indexPath.section
        ContainViewController.title = dataArray![indexPath.section]
        UIViewController.current()?.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onClick(_ sender: Any) {
        let rect = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
        roll = RollView(frame: rect)
        roll.setLabel(text: "正在更新")
        roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
        self.view.addSubview(roll)
        
        var update : Thread?
        update = Thread(target: self, selector: #selector(self.userUpdate), object: nil)
        update?.start()
    }
    
}
