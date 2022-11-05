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
    
    
    @IBAction func reviewButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toReviewsSegue", sender: nil)
        
        
        
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
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = searchTableView.indexPath(for: cell)!
        let book = searchedBooks[indexPath.row - 1]["volumeInfo"] as! NSDictionary
        
        let detailsViewController = segue.destination as! SearchBookDetailViewController
        detailsViewController.book = book
        
        searchTableView.deselectRow(at: indexPath, animated: true)
    }
     */
}
