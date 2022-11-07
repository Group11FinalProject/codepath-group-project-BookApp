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
        
        layer.backgroundColor = UIColor(red: 111/255, green: 160, blue: 250/255, alpha: 1).cgColor
        layer.cornerRadius = 20
    }

}
