//
//  IdenTitleTableViewCell.swift
//  RiveR
//
//  Created by Duoy on 2020/2/8.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class IdenTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var account: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
