//
//  ViewControllerExension.swift
//  RiveR
//
//  Created by Duoy on 2020/2/6.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

//获取当前的viewcontroller
extension UIViewController {
    class func current(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        if let table = base as? UITableViewController {
            return current(base: table)
        }
        return base
    }
    
    class func initAlert(msg: String, title: String, preferredStyle: UIAlertController.Style){
        let vc = current()
        let alertController = UIAlertController(title: title,
                        message: msg, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        vc?.present(alertController, animated: true, completion: nil)
    }
}
