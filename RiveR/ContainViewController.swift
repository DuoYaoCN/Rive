//
//  ContainViewController.swift
//  RiveR
//
//  Created by Duoy on 2020/2/9.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import Foundation
import UIKit

class ContainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var okBtn: UIButton!
    static var data : String?
    static var index : Int?
    static var title : String?
    
    var cell : UpdateTableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell(withIdentifier: "UpdateTableViewCellId", for: indexPath) as? UpdateTableViewCell
        if ContainViewController.index == 3 {
            self.cell.textfield.text = ContainViewController.data!.fromBase64()
        }
        else{
            self.cell.textfield.text = ContainViewController.data!
        }
        self.cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContainViewController.title!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ContainViewController.title!
        self.tableView.register(UINib.init(nibName: "UpdateTableViewCell", bundle: nil), forCellReuseIdentifier: "UpdateTableViewCellId")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    @IBAction func onClick(_ sender: Any) {
        self.cell.textfield.resignFirstResponder()
        if ContainViewController.index == 3 {
            ContainViewController.data = self.cell.textfield.text?.toBase64()
        }
        else{
            ContainViewController.data = self.cell.textfield.text
        }
        Defaults().save(index: ContainViewController.index!, string: ContainViewController.data!)
        UIViewController.current()?.navigationController?.popViewController(animated: true)
        UIViewController.current()?.viewDidLoad()
    }
    //点击return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.cell.textfield.resignFirstResponder()
        return true
    }
    //点击其他地方  收回键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.cell.textfield.resignFirstResponder()
    }
    
}
