//
//  Users.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

class Users {
    private var username = ""
    private var password = ""
    private var id = ""
    private var status = ""
    private var account = ""
    
    func set_username(username : String) -> Void{
        self.username = username
    }
    
    func set_password(password: String) -> Void {
        self.password = password
    }
    
    func set_id(id : String) -> Void {
        self.id = id
    }
    
    func set_status(status: String) -> Void {
        self.status = status
    }
    
    func set_account(account: String) -> Void {
        self.account = account
    }
    
    func get_username() -> String {
        return self.username
    }
    
    func get_password() -> String {
        return self.password
    }
    
    func get_id() -> String {
        return self.id
    }
    
    func get_status() -> String {
        return self.status
    }
    
    func get_account() -> String {
        return self.account
    }
}
