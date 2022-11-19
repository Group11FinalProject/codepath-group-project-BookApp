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
    
    @IBOutlet weak var featuredBookThumbsUp: UIButton!
    
    @IBOutlet weak var featuredBookThumbsDown: UIButton!
    
    @IBOutlet weak var discussionBoardLabel: UILabel!
    
    
    @IBOutlet weak var featuredBookThumbsDownNumber: UILabel!
    @IBOutlet weak var featuredBooksThumbsUpNumber: UILabel!
    
    @IBOutlet weak var featuredScrollViewView: UIView!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var book: NSDictionary!
    var recommendations = [PFObject]()
    var unRecommendations = [PFObject]()
    var recommendedBook = false
    var numRecs = 0
    //var recommendationsCount: Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        featuredScrollViewView.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        
        reviewsLabel.layer.masksToBounds = true
        discussionBoardLabel.layer.masksToBounds = true
        
        reviewsLabel.layer.cornerRadius = 14
        discussionBoardLabel.layer.cornerRadius = 14
        
        
        featuredBookTitleLabel.text = book["title"] as? String
        featuredBookAuthorLabel.text = book["author"] as? String
        //var numRecs = String(self.recommendations.count)
        //print(numRecs)
        //self.featuredBooksThumbsUpNumber.text = numRecs
        
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
        //let user = PFUser.current()!
        
        /*
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIndentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    
                    //var numRecs = String(self.recommendations.count)
                    //print(numRecs)
                    //self.featuredBooksThumbsUpNumber.text = String(numRecs)
                    //self.featuredBookThumbsUp.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: UIControl.State.normal)
                    //self.recommendedBook = true
                    
                    //self.reviewTableView.reloadData()
                }
            }
        } else {
            let industryIdentifier = book["primary_isbn10"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIdentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    
                    //var numRecs = String(self.recommendations.count)
                    //print(numRecs)
                    //self.featuredBooksThumbsUpNumber.text = String(numRecs)
                    //self.featuredBookThumbsUp.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: UIControl.State.normal)
                    //self.recommendedBook = true
                    //self.reviewTableView.reloadData()
                }
            }
            
            
            
        }
         
         
        if(user in recommendations) {
            print("It works")
        }
        
        else {
            print("Sorry")
        }
         
         */
        let recommendation = PFObject(className: "Recommendations")
        
        recommendation["currentUser"] = PFUser.current()!
        recommendation["numberedRec"] = numRecs
        recommendation["Recommended"] = true
        
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
                //self.recommendedBook = true
            }
            
            else {
                print("error saving recommendation")
            }
            
        }
        
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIndentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    var numRecs = String(self.recommendations.count)
                    print(numRecs)
                    self.featuredBooksThumbsUpNumber.text = String(numRecs)
                    self.featuredBookThumbsUp.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: UIControl.State.normal)
                    //self.recommendedBook = true
                    
                    //self.reviewTableView.reloadData()
                }
            }
        } else {
            let industryIdentifier = book["primary_isbn10"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIdentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    var numRecs = String(self.recommendations.count)
                    print(numRecs)
                    self.featuredBooksThumbsUpNumber.text = String(numRecs)
                    self.featuredBookThumbsUp.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: UIControl.State.normal)
                    //self.recommendedBook = true
                    //self.reviewTableView.reloadData()
                }
            }   
        }
        
        
        /*
         if featuredBooksThumbsUp.image == UIImage(systemName: "hand.thumbsup.fill") {
         numRecs -= 1
         print(numRecs)
         self.featuredBooksThumbsUpNumber.text = String(numRecs)
         featuredBooksThumbsUp.image = UIImage(systemName: "hand.thumbsup")
         //recommendation["Recommended"] = false
         
         }
         
         else { */
        
        //featuredBookThumbsUp.image = UIImage(systemName: "hand.thumbsup.fill")
        
        //numRecs += 1
        //var numRecs = String(self.recommendations.count)
        //print(numRecs)
        //self.featuredBooksThumbsUpNumber.text = String(numRecs)
        //recommendation["numberedRec"] = self.featuredBooksThumbsUpNumber.text
        //featuredBooksThumbsUp.image = UIImage(systemName: "hand.thumbsup.fill")
        
        //}
        
        
    }
    
    
    
    @IBAction func unRecommendBook(_ sender: Any) {
        let unRecommendation = PFObject(className: "Unrecommendations")
        
        unRecommendation["currentUser"] = PFUser.current()!
        unRecommendation["numberedRec"] = numRecs
        unRecommendation["Recommended"] = true
        
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            unRecommendation["identifier"] = industryIndentifier
        } else {
            
            let industryIdentifier = book["primary_isbn10"] as! String
            unRecommendation["identifier"] = industryIdentifier
        }
        
        unRecommendation.saveInBackground { (success, error) in
            if (success) {
                print("unrecommendation saved")
            }
            
            else {
                print("error saving unrecommendation")
            }
            
        }
        
        
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "Unrecommendations")
            query.whereKey("identifier", equalTo: industryIndentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (unRecommendations, error) in
                if unRecommendations != nil {
                    self.unRecommendations = unRecommendations!
                    var numUnRecs = String(self.unRecommendations.count)
                    print(numUnRecs)
                    self.featuredBookThumbsDownNumber.text = String(numUnRecs)
                    self.featuredBookThumbsDown.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: UIControl.State.normal)
                    
                    //self.reviewTableView.reloadData()
                }
            }
        } else {
            let industryIdentifier = book["primary_isbn10"] as! String
            
            let query = PFQuery(className: "Unrecommendations")
            query.whereKey("identifier", equalTo: industryIdentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (unRecommendations, error) in
                if unRecommendations != nil {
                    self.unRecommendations = unRecommendations!
                    var numUnRecs = String(self.unRecommendations.count)
                    print(numUnRecs)
                    self.featuredBookThumbsDownNumber.text = String(numUnRecs)
                    self.featuredBookThumbsDown.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: UIControl.State.normal)
                    //self.reviewTableView.reloadData()
                }
            }
            
            
            
        }
        
        
        /*
         if featuredBooksThumbsUp.image == UIImage(systemName: "hand.thumbsup.fill") {
         numRecs -= 1
         print(numRecs)
         self.featuredBooksThumbsUpNumber.text = String(numRecs)
         featuredBooksThumbsUp.image = UIImage(systemName: "hand.thumbsup")
         //recommendation["Recommended"] = false
         
         }
         
         else { */
        
        //featuredBookThumbsUp.image = UIImage(systemName: "hand.thumbsup.fill")
        
        //numRecs += 1
        //var numRecs = String(self.recommendations.count)
        //print(numRecs)
        //self.featuredBooksThumbsUpNumber.text = String(numRecs)
        //recommendation["numberedRec"] = self.featuredBooksThumbsUpNumber.text
        //featuredBooksThumbsUp.image = UIImage(systemName: "hand.thumbsup.fill")
        
        //}
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if book["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = book["industryIdentifiers"] as? [NSDictionary]
            
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIndentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    var numRecs = String(self.recommendations.count)
                    print(numRecs)
                    self.featuredBooksThumbsUpNumber.text = String(numRecs)
                    //self.reviewTableView.reloadData()
                }
            }
        } else {
            let industryIdentifier = book["primary_isbn10"] as! String
            
            let query = PFQuery(className: "Recommendations")
            query.whereKey("identifier", equalTo: industryIdentifier)
            query.includeKey("currentUser")
            //query.order(byDescending: "createdAt")
            //query.limit = 10
            
            query.findObjectsInBackground { (recommendations, error) in
                if recommendations != nil {
                    self.recommendations = recommendations!
                    var numRecs = String(self.recommendations.count)
                    print(numRecs)
                    self.featuredBooksThumbsUpNumber.text = String(numRecs)
                    //self.reviewTableView.reloadData()
                }
            }
            
            
            
        }
        
        // var numRecs = String(self.recommendations.count)
        // print(numRecs)
        // self.featuredBooksThumbsUpNumber.text = String(numRecs)
        
        
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
