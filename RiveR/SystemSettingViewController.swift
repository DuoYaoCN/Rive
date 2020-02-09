
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataarray = ["退出登录", "注销账户"]
        self.tableview.register(UINib.init(nibName: "SystemSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SystemSettingTableViewCellId")
        self.tableview.dataSource = self
        self.tableview.delegate = self
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
        var roll : RollView!
        let rect = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
        roll = RollView(frame: rect)
        roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
        self.view.addSubview(roll)
        if indexPath.section == 1{
            let group = DispatchGroup()
            let globalQueue = DispatchQueue.global()//创建一个全局队列
            let delete = UserDelete()
            globalQueue.async(group: group, execute: {
                delete.request(account: Defaults().get(key: Users_struct().userAccount))
            })
            group.notify(queue: globalQueue, execute: {
                //检测到所有的任务都执行完了，我们可以做一个通知或者说UI的处理
                Thread.sleep(forTimeInterval: 2)
                if delete.dat == nil{
                    Thread.sleep(forTimeInterval: 5)
                    DispatchQueue.main.async {
                        if delete.dat == nil{
                            roll.removeFromSuperview()
                        }
                        else{
                            print("error")
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        roll.removeFromSuperview()

                    }
                }
            })
        }
        Defaults().remove()
        self.navigationController?.popViewController(animated: true)
        UIViewController.current()?.viewDidLoad()
    }
    
}
