//
//  Cookies.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import Foundation

class Defaults {
    static let defaults = UserDefaults.standard
    
    func save(index:Int, string:String){
        Defaults.defaults.set(string, forKey: Users_struct().get(index: index)!)
        Defaults.defaults.synchronize()
    }
    //保存用户session
    func save(users:Users){
        Defaults.defaults.set(users.get_username(), forKey: Users_struct().username)
        Defaults.defaults.set(users.get_password(), forKey: Users_struct().userpasswd)
        Defaults.defaults.set(users.get_account(), forKey: Users_struct().userAccount)
        Defaults.defaults.set(users.get_id(), forKey: Users_struct().userId)
        Defaults.defaults.set(users.get_status(), forKey: Users_struct().userStatus)
        Defaults.defaults.synchronize()
    }
    //保存用户设置
    func save(){
        Defaults.defaults.set(Setting.editSwitch, forKey: Setting().saving)
    }

    func get(key:String) -> String{
        guard let name = Defaults.defaults.string(forKey: key) else { return "" }
        return name
    }
    

    func remove(){
        //移除userDefaults数据
        Defaults.defaults.removeObject(forKey: Users_struct().username)
        Defaults.defaults.removeObject(forKey: Users_struct().userpasswd)
        Defaults.defaults.removeObject(forKey: Users_struct().userAccount)
        Defaults.defaults.removeObject(forKey: Users_struct().userId)
        Defaults.defaults.removeObject(forKey: Users_struct().userStatus)
        Defaults.defaults.removeObject(forKey: Setting().saving)
        Defaults.defaults.synchronize()
    }
}
