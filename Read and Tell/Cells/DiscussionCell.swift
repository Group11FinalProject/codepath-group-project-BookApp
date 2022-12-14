//
//  DiscussionCell.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/9/22.
//

import UIKit

class DiscussionCell: UITableViewCell {
    
    
    @IBOutlet weak var discussionUserProfileImageView: UIImageView!
    @IBOutlet weak var discussionUserNameLabel: UILabel!
    @IBOutlet weak var discussionUserTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
