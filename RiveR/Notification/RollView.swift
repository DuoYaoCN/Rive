//
//  RollView.swift
//  testFlash
//
//  Created by Duoy on 2020/2/7.
//  Copyright © 2020 雲の祈り. All rights reserved.
//

import UIKit

class RollView: UIView {
    private var aut :UIActivityIndicatorView!
    
    private var label : UILabel!
    
    var text : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let label_width = rect.width * 3/4
        let label_height = rect.height / 6
        let label_x =  rect.width / 8
        let label_y = rect.height * 2/3
        let aut_wih = rect.width / 2
        let aut_x = rect.width / 4
        let aut_y = rect.height / 6
        self.aut = UIActivityIndicatorView.init(frame: CGRect(x: aut_x, y: aut_y, width: aut_wih, height: aut_wih))
        self.aut.style = UIActivityIndicatorView.Style.large
        self.aut.color = UIColor.black
        self.aut.isHidden = false
        self.aut.startAnimating()
        self.label = UILabel(frame: CGRect(x: label_x, y: label_y, width: label_width, height: label_height))
        self.label.text = self.text
        self.label.textColor = UIColor.gray
        self.label.textAlignment = .center
        self.label.adjustsFontSizeToFitWidth = true
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 0.5
        self.addSubview(self.aut)
        self.addSubview(self.label)
    }
    func setLabel(text:String){
        self.text = text
    }
}
