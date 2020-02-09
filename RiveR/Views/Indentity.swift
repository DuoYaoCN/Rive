//
//  indentity.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class Identity: UIView, NibLoadable, UITableViewDelegate, UITableViewDataSource{
    var dataArray:Array<String>?
    @IBOutlet weak var tableview: UITableView!
    
    func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    
    func show() {
        self.dataArray = ["拍摄的照片是否保存入系统相册", "系统设置"]
        tableview.register(UINib.init(nibName: "IdenTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "IdenTitleTableViewCellId")
        tableview.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCellId")
        tableview.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCellId")
        tableview.rowHeight = self.frame.height
        //设置代理和数据源
        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.reloadData()
    }
    
    /**
        The functions blow is controller of TableView
     */
    
    //画几个tablecell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        else{
            return 2
        }
    }
    
    //有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //索引栏标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "设置"
        }
        return ""
    }
    
    //设置每个cell的高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 119
        }
        else{
            return 60
        }
    }
    
    //返回一个cell对象
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : IdenTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IdenTitleTableViewCellId", for: indexPath) as! IdenTitleTableViewCell
            cell.account.text = Defaults().get(key: Users_struct().userAccount)
            cell.username.text = Defaults().get(key: Users_struct().username)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        switch indexPath.row {
        case 0: do {
            let cell: IndentityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath) as! IndentityTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.label.text = self.dataArray?[indexPath.row]
            cell.switch.isOn = Defaults.defaults.bool(forKey: Setting().saving)
            cell.switch.addTarget(self, action: #selector(editSwitchDidChange(_:)), for: .valueChanged)
            return cell
        }
        default: do{
            let cell: SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCellId", for: indexPath) as! SettingTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.default
            cell.label.text = self.dataArray?[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
            }
        }
    }

    //监听cell是否被点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vc = NativeViewCntroller()
        //self.present(vc, animated: true)
        if(indexPath.section == 0){
            //跳转
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "VC")
            UIViewController.current()?.navigationController?.pushViewController(vc, animated: true)
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }
        if indexPath.section == 1 && indexPath.row == 1{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "system")
            UIViewController.current()?.navigationController?.pushViewController(vc, animated: true)
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }
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
