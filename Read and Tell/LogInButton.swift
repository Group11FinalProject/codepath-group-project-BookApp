//
//  LogInButton.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/6/22.
//

import UIKit

class LogInButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.backgroundColor = UIColor(red: 170.0/255.0, green: 195.0/255.0, blue: 161.0/255.0, alpha: 1.0/1.0).cgColor
        layer.cornerRadius = 20
    }

}
