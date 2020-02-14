//
//  SceneryOCR.swift
//  RiveR
//
//  Created by Duoy on 2020/2/4.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import Vision

//判断用户是否合法
class UserDelete {
    private let url = "delete"
    //请求API接口
    init(){
    }
    func  request(account:String) {
        //接口地址（使用http://也可以，记得再info.plist里做相关的配置）
        let httpUrl = HTTP_struct().host + self.url + "/" + account
        //参数拼接
        let config = URLSessionConfiguration.default
        let url = URL(string: String(format: httpUrl))
        //创建请求对象
        var request = URLRequest(url: url!)
        request.timeoutInterval = 6
        request.httpMethod = "DELETE"
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {(data, response, error) -> Void in
                                            if error != nil{
                                                let notName = Notification.Name(rawValue: Sign().system_error)
                                                NotificationCenter.default.post(name: notName, object: nil)
                                            }else if data != nil{
                                                let newStr = String(data: data!, encoding: String.Encoding.utf8)
                                                if (newStr?.elementsEqual("200"))!{
                                                    let notName = Notification.Name(rawValue: Sign().delete_success)
                                                    NotificationCenter.default.post(name: notName, object: nil)
                                                }
                                                else{
                                                    let notName = Notification.Name(rawValue: Sign().delete_error)
                                                    NotificationCenter.default.post(name: notName, object: nil)
                                                }
                                                
                                            }}) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
    }
}
