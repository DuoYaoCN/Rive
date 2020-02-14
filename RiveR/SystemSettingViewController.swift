
//
//  SystemSettingViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/9.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import Foundation
import UIKit

class SystemSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableview: UITableView!
    
    var dataarray : Array<String>?
    
    var roll : RollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataarray = ["退出登录", "注销账户"]
        self.tableview.register(UINib.init(nibName: "SystemSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SystemSettingTableViewCellId")
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        /// 注册通知组件
        // 成功
        NotificationCenter.default.addObserver(self, selector: #selector(self.delSuccess), name: Notification.Name(rawValue: Sign().delete_success), object: nil)
        // 失败
        NotificationCenter.default.addObserver(self, selector: #selector(self.delError), name: Notification.Name(rawValue: Sign().delete_error), object: nil)
        
        // 服务器出现问题
        NotificationCenter.default.addObserver(self, selector: #selector(self.sysError), name: Notification.Name(rawValue: Sign().system_error), object: nil)
    }
    
    @objc func delSuccess(){
        DispatchQueue.main.async {
            self.roll.removeFromSuperview()
            /// 删除通知组件
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().delete_success), object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().delete_error), object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
            
            Defaults().remove()
            self.navigationController?.popViewController(animated: true)
            UIViewController.current()?.viewDidLoad()
        }
    }
    
    @objc func delError(){
        DispatchQueue.main.async {
            self.roll.removeFromSuperview()
            UIViewController.initAlert(msg: "删除失败", title: "系统提示", preferredStyle: .alert)
        }
    }
    
    @objc func sysError(){
        DispatchQueue.main.async {
            self.roll.removeFromSuperview()
            UIViewController.initAlert(msg: "无法连接到服务器", title: "系统提示", preferredStyle: .alert)
        }
    }
    
    @objc func delUser(){
        DispatchQueue.main.async {
            let delete = UserDelete()
            delete.request(account: Defaults().get(key: Users_struct().userAccount))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SystemSettingTableViewCellId", for: indexPath) as! SystemSettingTableViewCell
        cell.textfield.text = dataarray![indexPath.section]
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.textfield.textColor = UIColor.black
        }
        else if indexPath.section == 1{
            cell.textfield.textColor = UIColor.red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataarray!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            var del : Thread?
            del = Thread(target: self, selector: #selector(self.delUser), object: nil)
            del?.start()
            
            let rect = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
            self.roll = RollView(frame: rect)
            self.roll.setLabel(text: "正在删除")
            self.roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
            self.view.addSubview(self.roll)
        }
        else {
            /// 删除通知组件
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().delete_success), object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().delete_error), object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Sign().system_error), object: nil)
            
            Defaults().remove()
            self.navigationController?.popViewController(animated: true)
            UIViewController.current()?.viewDidLoad()
        }
    }
    
}
