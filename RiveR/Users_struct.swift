//
//  Users.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

struct Users_struct {
    let userId = "id"
    let userAccount = "account"
    let username = "username"
    let userpasswd = "password"
    let userStatus = "status"
    
    func get(index:Int) -> String?{
        switch index {
        case 0: return self.userId
        case 1: return self.userAccount
        case 2: return self.username
        case 3: return self.userpasswd
        case 4: return self.userStatus
        default: return nil
        }
    }
}


