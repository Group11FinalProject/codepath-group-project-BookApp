//
//  BookSearchCell.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 10/31/22.
//

import UIKit

class BookSearchCell: UITableViewCell {

    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
