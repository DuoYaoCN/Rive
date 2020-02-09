//
//  AccountTableViewCell.swift
//  RiveR
//
//  Created by Duoy on 2020/2/8.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var title: UILabel!

    @IBOutlet var userdata: UILabel!
    
    var i = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    
}
