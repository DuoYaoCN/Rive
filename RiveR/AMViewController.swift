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
            Defaults().remove()
            self.navigationController?.popToRootViewController(animated: true)
            SelfViewController().viewDidLoad()
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}
