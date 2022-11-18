//
//  NameCell.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/14/22.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var nameInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
