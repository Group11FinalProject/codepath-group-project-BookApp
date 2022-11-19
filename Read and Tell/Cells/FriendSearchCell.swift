//
//  FriendSearchCell.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/19/22.
//

import UIKit

class FriendSearchCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
