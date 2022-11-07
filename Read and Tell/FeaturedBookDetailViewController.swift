//
//  FeaturedBookDetailViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/3/22.
//

import UIKit
import Parse

class FeaturedBookDetailViewController: UIViewController {

    @IBOutlet weak var featuredBookImageView: UIImageView!
    @IBOutlet weak var featuredBookTitleLabel: UILabel!
    @IBOutlet weak var featuredBookAuthorLabel: UILabel!
    @IBOutlet weak var featuredBookReleaseYear: UILabel!
    @IBOutlet weak var featuredBookDescriptionLabel: UILabel!
    @IBOutlet weak var featuredBookStar1: UIImageView!
    @IBOutlet weak var featuredBookStar2: UIImageView!
    @IBOutlet weak var featuredBookStar3: UIImageView!
    @IBOutlet weak var featuredBookStar4: UIImageView!
    @IBOutlet weak var featuredBookStar5: UIImageView!

    var book: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func featuredBookSaveToCollection(_ sender: Any) {
        let user = PFUser.current()!

        user.add(book, forKey: "bookCollection")
        
        user.saveInBackground { (success, error) in
            if(success) {
                print("book saved to collection")
            }
            else {
                print("book not saved")
            }
        }
    }

    @IBAction func featuredBookReviewButton(_ sender: Any) {
        self.performSegue(withIdentifier: "fromFeaturedToReviewsSegue", sender: nil)
    }
        
    func getWeeks() {
        let weekCount = book["averageRating"] as? Double ?? 0
        
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
