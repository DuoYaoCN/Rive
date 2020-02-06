//
//  indentity.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import Foundation
import UIKit

class Identity: UIView, NibLoadable, UITableViewDelegate, UITableViewDataSource{
    static var dataArray:Array<String>?
    @IBOutlet weak var logout: UIButton!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func toLogout(_ sender: Any) {
        Defaults().remove()
        let login = LoginView.loadFromNib("login")
        login.show()
        self.addSubview(login)
        
    }
    func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    
    func show() {
        Identity.dataArray = ["拍摄的照片是否保存入系统相册", "账号设置"]
        tableview.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCellId")
        tableview.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCellId")
        //设置代理和数据源
        tableview.delegate = self
        tableview.dataSource = self
        self.username.text = Defaults.defaults.value(forKey: Users_struct().username) as? String
    }
    
    /**
        The functions blow is controller of TableView
     */
    
    //画几个tablecell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Identity.dataArray!.count
    }
    
    //有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    //索引栏标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "设置"
    }
    
    //设置每个cell的高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
    //返回一个cell对象
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0: do {
            let cell: IndentityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath) as! IndentityTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.label.text = Identity.dataArray?[indexPath.row]
            cell.switch.isOn = Defaults.defaults.bool(forKey: Setting().saving)
            cell.switch.addTarget(self, action: #selector(editSwitchDidChange(_:)), for: .valueChanged)
            return cell
        }
        default: do{
            let cell: SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCellId", for: indexPath) as! SettingTableViewCell
            cell.label.text = Identity.dataArray?[indexPath.row]
            return cell
            }
        }

    }
    
    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        <#code#>
    }
    
    //监听cell的开关状态
    @objc func editSwitchDidChange(_ sender: UISwitch){
        let set = Setting()
        if sender.isOn{
            set.setEdit(edit: true)
        }
        else{
            set.setEdit(edit: false)
        }
        Defaults().save()
    }
}
