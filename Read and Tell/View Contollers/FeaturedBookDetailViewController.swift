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
    @IBOutlet weak var featuredBookThumbsDown: UIImageView!
    @IBOutlet weak var featuredBooksThumbsUp: UIImageView!
    @IBOutlet weak var featuredBookThumbsDownNumber: UILabel!
    @IBOutlet weak var featuredBooksThumbsUpNumber: UILabel!
    
    var book: NSDictionary!
    var recommendations = [PFObject]()
    //var recommendationsCount: Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featuredBookTitleLabel.text = book["title"] as? String
        featuredBookAuthorLabel.text = book["author"] as? String
        //featuredBooksThumbsUpNumber.text = String(self.recommendations.count)
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
    
    
    @IBAction func reccomendBook(_ sender: Any) {
        
        let recommendation = PFObject(className: "Recommendations")
        
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            recommendation["identifier"] = industryIndentifier
        } else {
            
            let industryIdentifier = book["primary_isbn10"] as! String
            recommendation["identifier"] = industryIdentifier
        }
        
        recommendation.saveInBackground { (success, error) in
            if (success) {
                print("recommendation saved")
            }
            
            else {
                print("error saving recommendation")
            }
        }
        
        
        featuredBooksThumbsUpNumber.text = String(self.recommendations.count)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIndentifier)
            //query.includeKeys(["author", "text"])
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    //self.reviewTableView.reloadData()
                }
            }
        } else {
            let industryIdentifier = book["primary_isbn10"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIdentifier)
            //query.includeKeys(["author", "text"])
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    //self.reviewTableView.reloadData()
                }
            }
            
        }
        
        //featuredBooksThumbsUpNumber.text = String(self.recommendations.count)
        
        //reviewTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "featuredToReviews" {
            
            let featuredBook = book!
            let reviewsViewController = segue.destination as! ReviewsContentViewController
            reviewsViewController.bookReviews = featuredBook
            
        } else {
            
            let featuredBook = book!
            let discussionViewController = segue.destination as! DiscussionContentViewController
            discussionViewController.bookDiscussion = featuredBook
        }
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
