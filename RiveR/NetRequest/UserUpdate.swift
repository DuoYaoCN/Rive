//
//  UserUpdate.swift
//  RiveR
//
//  Created by Duoy on 2020/2/9.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import Vision

//判断用户是否合法
class UserUpdate {
    private let url = "update"
    //请求API接口
    var result : String?
    var error : Error?
    var dat : Data?
    init(){
    }
    func  request(user:Users) {
        //接口地址（使用http://也可以，记得再info.plist里做相关的配置）
        var httpUrl = HTTP_struct().host + self.url + "/" + user.get_account() + "/"
        httpUrl = httpUrl + user.get_username() + "/" + user.get_password().fromBase64()! + "/"
        httpUrl = httpUrl + user.get_status() + "/" + user.get_id()
        //参数拼接
        let config = URLSessionConfiguration.default
        let url = URL(string: String(format: httpUrl))
        //创建请求对象
        var request = URLRequest(url: url!)
        request.timeoutInterval = 6
        request.httpMethod = "POST"
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {(data, response, error) -> Void in
                                            if error != nil{
                                                let notName = Notification.Name(rawValue: Sign().system_error)
                                                NotificationCenter.default.post(name: notName, object: nil)
                                            }else if data != nil{
                                                let newStr = String(data: data!, encoding: String.Encoding.utf8)
                                                if (newStr?.elementsEqual("200"))!{
                                                    let notName = Notification.Name(rawValue: Sign().update_success)
                                                    NotificationCenter.default.post(name: notName, object: nil)
                                                }
                                                else{
                                                    let notName = Notification.Name(rawValue: Sign().update_error)
                                                    NotificationCenter.default.post(name: notName, object: nil)
                                                }
                                            }}) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
    }
}
