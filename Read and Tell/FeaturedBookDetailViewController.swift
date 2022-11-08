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
    @IBOutlet weak var featuredBookDescriptionLabel: UILabel!
    

    @IBOutlet weak var featuredBooksWeeksLabel: UILabel!
    
    

    var book: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featuredBookTitleLabel.text = book["title"] as? String
        
        featuredBookAuthorLabel.text = book["author"] as? String
        
        let featuredBookImage = book["book_image"] as! String
        
        let featuredBookImageUrl = URL(string: featuredBookImage)
        
        
        featuredBookImageView.af.setImage(withURL: featuredBookImageUrl!)
        
        featuredBookDescriptionLabel.text = book["description"] as? String
        
        let numWeeks = (book["weeks_on_list"])!
        
        featuredBooksWeeksLabel.text = "This book has been on Top Sellers for \(numWeeks) weeks!"
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func featuredBookSaveToCollection(_ sender: Any) {
        let user = PFUser.current()!
        let featuredBookObject = PFObject(className: "Books")
        
        featuredBookObject["user"] = user
        featuredBookObject["title"] = book["title"]
        featuredBookObject["imageLink"] = book["book_image"]
        
        

        
        featuredBookObject.saveInBackground { (success, error) in
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
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
