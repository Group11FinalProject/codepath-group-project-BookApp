//
//  FeaturedBookDetailViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/3/22.
//

import UIKit

class FeaturedBookDetailViewController: UIViewController {

    @IBOutlet weak var featuredBookImageView: UIImageView!
    @IBOutlet weak var featuredBookTitleLabel: UILabel!
    @IBOutlet weak var featuredBookAuthorLabel: UILabel!
    @IBOutlet weak var featuredBookDescriptionLabel: UILabel!
    
    var book: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
