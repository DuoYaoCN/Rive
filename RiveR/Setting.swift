//
//  Setting.swift
//  RiveR
//
//  Created by Duoy on 2020/2/6.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import Foundation

struct Setting {
    let saving = "SAVESETTING"
    static var editSwitch:Bool = true //保存至相册
    func setEdit(edit :Bool){
        Setting.editSwitch = edit
    }
}
