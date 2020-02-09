//
//  UpdateTableViewCell.swift
//  RiveR
//
//  Created by Duoy on 2020/2/9.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class UpdateTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textfield.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

}
