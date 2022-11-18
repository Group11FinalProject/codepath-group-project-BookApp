//
//  ProfileCustomLabel.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/14/22.
//

import UIKit

class ProfileCustomLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}
