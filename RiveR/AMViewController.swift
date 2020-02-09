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
        //cell.accessoryType = .disclosureIndicator
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
        UIViewController.current()?.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onClick(_ sender: Any) {
        var roll : RollView!
        let rect = CGRect(x: self.view.center.x-50, y: self.view.center.y-50, width: 100, height: 100)
        roll = RollView(frame: rect)
        roll.backgroundColor = UIColor(displayP3Red: 182, green: 179, blue: 182, alpha: 0.8)
        self.view.addSubview(roll)
        let user = Users()
        user.set_id(id: Defaults().get(key: Users_struct().userId))
        user.set_username(username: Defaults().get(key: Users_struct().username))
        user.set_account(account: Defaults().get(key: Users_struct().userAccount))
        user.set_password(password: Defaults().get(key: Users_struct().userpasswd))
        user.set_status(status: Defaults().get(key: Users_struct().userStatus))
        let update = UserUpdate()
        let group = DispatchGroup()
        let globalQueue = DispatchQueue.global()//创建一个全局队列
        globalQueue.async(group: group, execute: {
            update.request(user: user)
        })
        group.notify(queue: globalQueue, execute: {
            //检测到所有的任务都执行完了，我们可以做一个通知或者说UI的处理
            Thread.sleep(forTimeInterval: 2)
            if update.dat == nil{
                Thread.sleep(forTimeInterval: 5)
                DispatchQueue.main.async {
                    if update.dat == nil{
                        let identity = Identity.loadFromNib("indentity")
                        identity.show()
                        roll.removeFromSuperview()
                        self.navigationController?.popViewController(animated: true)
                        UIViewController.current()?.viewDidLoad()
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
                    self.navigationController?.popViewController(animated: true)
                    UIViewController.current()?.viewDidLoad()
                    UIViewController.current()?.view.addSubview(identity)

                }
            }
        })
    }
    
}
