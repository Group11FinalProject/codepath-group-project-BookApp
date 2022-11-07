//
//  CustomTextField.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/6/22.
//

import UIKit

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        layer.backgroundColor = UIColor(red: 249/255, green: 250/255, blue: 250/255, alpha: 1).cgColor
        
        layer.cornerRadius = 15.0
        clipsToBounds = true
        layer.borderWidth = 1
        
        
    }

}
