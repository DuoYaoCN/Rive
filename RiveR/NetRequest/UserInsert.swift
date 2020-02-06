//
//  UserInsert.swift
//  RiveR
//
//  Created by Duoy on 2020/2/5.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import Vision

//返回用户
class UserInsert {
    private let url = "insert"

    //请求API接口
    var user = Users()
    init(){
    }
    func  request(account:String, username:String, password:String, status:String) {
        //接口地址（使用http://也可以，记得再info.plist里做相关的配置）
        let httpUrl = HTTP_struct().host + self.url + "/" + account + "/" + username + "/" + password + "/" + status
        //参数拼接
        let config = URLSessionConfiguration.default
        let url = URL(string: String(format: httpUrl))
        //创建请求对象
        var request = URLRequest(url: url!)
        request.timeoutInterval = 6
        request.httpMethod = "PUT"
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {(data, response, error) -> Void in
                                            if error != nil{
                                                print(error.debugDescription)
                                            }else if let d = data{
                                                 let newStr = String(data: d, encoding: String.Encoding.utf8)
                                                //注册后自动登录
                                                self.user.set_id(id: newStr!)
                                                self.user.set_account(account: account)
                                                self.user.set_username(username: username)
                                                self.user.set_password(password: password)
                                                self.user.set_status(status: status)
                                                Defaults().remove()
                                                Defaults().save()
                                                Defaults().save(users: self.user)
                                                
                                            }}) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
    }
}
