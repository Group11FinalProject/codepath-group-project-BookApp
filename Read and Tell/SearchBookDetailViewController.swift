//
//  SearchBookDetailViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/3/22.
//

import UIKit
import AlamofireImage
import Parse

class SearchBookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var book: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTitleLabel.text = book["title"] as? String
        
        let authorArray = book["authors"] as? NSArray
        authorNameLabel.text = authorArray?[0] as? String ?? "N/A"
        
        let imageLinksArray = book["imageLinks"] as? NSDictionary
        if imageLinksArray != nil {
            let bookCoverImage = imageLinksArray?["thumbnail"] as! String
            let bookCoverImageUrl = URL(string: bookCoverImage)
            bookImageView.af.setImage(withURL: bookCoverImageUrl!)
        } else {
            bookImageView.image = UIImage(named: "book_cover_unavailable")
        }
        
        let yearString = book["publishedDate"] as? String
        if yearString != nil {
            let yearSubString = yearString!.prefix(4)
            releaseYearLabel.text = String(yearSubString)
        } else {
            releaseYearLabel.text = ""
        }
        
        synopsisLabel.text = book["description"] as? String
        
        getRating()
    }
    
    
    @IBAction func saveToCollection(_ sender: Any) {
        let user = PFUser.current()!
        let bookObject = PFObject(className: "Books")
        
        bookObject["user"] = user
        bookObject["title"] = book["title"]
        
        let imageLinksArray = book["imageLinks"] as? NSDictionary
        bookObject["imageLink"] = imageLinksArray?["thumbnail"] as! String

        //user.add(collection, forKey: "bookCollection")
        
        bookObject.saveInBackground { (success, error) in
            if(success) {
                print("book saved to collection")
            }
            else {
                print("book not saved")
            }
        }
    }

    func getRating() {
        let starCount = book["averageRating"] as? Double ?? 0
        
        switch(starCount) {
        case 0.5:
            star1.image = UIImage(systemName: "star.lefthalf.fill")
            star2.image = UIImage(systemName: "star")
            star3.image = UIImage(systemName: "star")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        case 1:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star")
            star3.image = UIImage(systemName: "star")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        case 1.5:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.lefthalf.fill")
            star3.image = UIImage(systemName: "star")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        case 2:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        case 2.5:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.lefthalf.fill")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        case 3:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        case 3.5:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.lefthalf.fill")
            star5.image = UIImage(systemName: "star")
        case 4:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.fill")
            star5.image = UIImage(systemName: "star")
        case 4.5:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.fill")
            star5.image = UIImage(systemName: "star.lefthalf.fill")
        case 5:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.fill")
            star5.image = UIImage(systemName: "star.fill")
        default:
            star1.image = UIImage(systemName: "star")
            star2.image = UIImage(systemName: "star")
            star3.image = UIImage(systemName: "star")
            star4.image = UIImage(systemName: "star")
            star5.image = UIImage(systemName: "star")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let button = sender as! UIButton
        /*
        let bookReviews = book!
        
        let reviewsViewController = segue.destination as! ReviewsContentViewController
        reviewsViewController.bookReviews = bookReviews
        */
        
        if segue.identifier == "toReviews" {
            
            let searchedBook = book!
            let reviewsViewController = segue.destination as! ReviewsContentViewController
            reviewsViewController.bookReviews = searchedBook
            
        } else {
            
            let searchedBook = book!
            let discussionViewController = segue.destination as! DiscussionContentViewController
            discussionViewController.bookDiscussion = searchedBook
        }
    }
}
