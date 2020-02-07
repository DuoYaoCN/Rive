//
//  UsersGet.swift
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
class UserGet {
    private let url = "get"
    //请求API接口
    var user = Users()
    var error :Error?
    init(){
    }
    func  request(account:String) {
        var json : JSON!
        //接口地址（使用http://也可以，记得再info.plist里做相关的配置）
        let httpUrl = HTTP_struct().host + self.url + "/" + account
        //参数拼接
        let config = URLSessionConfiguration.default
        let url = URL(string: String(format: httpUrl))
        //创建请求对象
        var request = URLRequest(url: url!)
        request.timeoutInterval = 6
        request.httpMethod = "GET"
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {(data, response, error) -> Void in
                                            if error != nil{
                                                self.error = error!
                                            }else if let d = data{
                                                json = try! JSON(data: d)
                                                self.user.set_id(id: json[Users_struct().userId].string!)
                                                self.user.set_account(account: json[Users_struct().userAccount].string!)
                                                self.user.set_username(username: json[Users_struct().username].string!)
                                                self.user.set_password(password: json[Users_struct().userpasswd].string!)
                                                self.user.set_status(status: json[Users_struct().userStatus].string!)
                                                Defaults().remove()
                                                Defaults().save()
                                                Defaults().save(users: self.user)
                                                
                                            }}) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
    }
}

