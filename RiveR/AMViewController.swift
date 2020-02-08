//
//  AMViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/6.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class AMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var dataArray:Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "account")
        self.dataArray = ["修改信息", "注销账号"]
        //设置代理和数据源
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /**
        The functions blow is controller of TableView
     */
    
    //画几个tablecell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    //有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //索引栏标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "设置"
    }
    
    //设置每个cell的高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    //返回一个cell对象
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath) as! AccountTableViewCell
        cell.label.text = self.dataArray?[indexPath.row]
        return cell
    }

    //监听cell是否被点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //跳转
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "update")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            //注销
            var roll : RollView!
            let rect = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
            roll = RollView(frame: rect)
            roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
            //roll.setLabel(label: "正在登录")
            self.view.addSubview(roll)
            let group = DispatchGroup()
            let globalQueue = DispatchQueue.global()//创建一个全局队列
            let del = UserDelete()
            globalQueue.async(group: group, execute: {
                del.request(account: Defaults().get(key: Users_struct().userAccount))
            })
            group.notify(queue: globalQueue, execute: {
                //检测到所有的任务都执行完了，我们可以做一个通知或者说UI的处理
                Thread.sleep(forTimeInterval: 2)
                if del.dat == nil{
                    Thread.sleep(forTimeInterval: 5)
                    DispatchQueue.main.async {
                        if del.dat == nil{
                            Defaults().remove()
                            roll.removeFromSuperview()
                            self.navigationController?.popToRootViewController(animated: true)
                            let login = LoginView.loadFromNib("login")
                            login.show()
                            UIViewController.current()?.view.addSubview(login)
                            
                        }
                        else{
                            print("error")
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        Defaults().remove()
                        roll.removeFromSuperview()
                        self.navigationController?.popToRootViewController(animated: true)
                        let login = LoginView.loadFromNib("login")
                        login.show()
                        UIViewController.current()?.view.addSubview(login)
                    }
                }
            })
            
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
   
}
