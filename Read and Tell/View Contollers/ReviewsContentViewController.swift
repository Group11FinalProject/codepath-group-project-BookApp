//
//  ReviewsContentViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/4/22.
//

import UIKit
import Parse
import MessageInputBar

class ReviewsContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var reviewTableView: UITableView!
    let reviewBar = MessageInputBar()
    var showsReviewBar = false
    var reviews = [PFObject]()
    var bookReviews: NSDictionary!
    let cell = UITableViewCell()
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRefreshControl.addTarget(self, action: #selector(onRefresh), for: UIControl.Event.valueChanged)
        reviewTableView.insertSubview(myRefreshControl, at: 0)
        
        reviewBar.inputTextView.placeholder = "Add a review..."
        reviewBar.sendButton.image = UIImage(systemName: "pencil.line")
        
        reviewBar.delegate = self
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        reviewTableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //onRefresh() and run() functions are for the refreshing feature
    @objc func onRefresh() {
        run(after: 1.5) {
            self.myRefreshControl.endRefreshing()
            self.reviewTableView.reloadData()
        }
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        reviewBar.inputTextView.text = nil
        showsReviewBar = false
        becomeFirstResponder()
        
    }
    
    override var inputAccessoryView: UIView? {
        return reviewBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsReviewBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let review = PFObject(className: "Reviews")
        
        review["text"] = text
        review["author"] = PFUser.current()!
        review["title"] = bookReviews["title"]
        
        
        if bookReviews["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = bookReviews["industryIdentifiers"] as? [NSDictionary]
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            review["identifier"] = industryIndentifier
        } else {
            
            let industryIdentifier = bookReviews["primary_isbn10"] as! String
            review["identifier"] = industryIdentifier
        }
        
        review.saveInBackground { (success, error) in
            if (success) {
                print("review saved")
            }
            
            else {
                print("error saving review")
            }
        }
        
        reviewTableView.reloadData()
        
        reviewBar.inputTextView.text = nil
        showsReviewBar = false
        becomeFirstResponder()
        reviewBar.inputTextView.resignFirstResponder()
        
        viewDidAppear(true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if bookReviews["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = bookReviews["industryIdentifiers"] as? [NSDictionary]
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "Reviews")
            query.whereKey("identifier", equalTo: industryIndentifier)
            query.includeKeys(["author", "text"])
            query.order(byDescending: "createdAt")
            query.limit = 10
            
            query.findObjectsInBackground { (reviews, error) in
                if reviews != nil {
                    self.reviews = reviews!
                    self.reviewTableView.reloadData()
                }
            }
        } else {
            let industryIdentifier = bookReviews["primary_isbn10"] as! String
            
            let query = PFQuery(className: "Reviews")
            query.whereKey("identifier", equalTo: industryIdentifier)
            query.includeKeys(["author", "text"])
            query.order(byDescending: "createdAt")
            query.limit = 10
            
            query.findObjectsInBackground { (reviews, error) in
                if reviews != nil {
                    self.reviews = reviews!
                    self.reviewTableView.reloadData()
                }
            }
            
        }
        
        reviewTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "AddReviewCell")!
            
            return cell
        } else if indexPath.row <= reviews.count {
            reviewTableView.rowHeight = 150
            
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
            let review = reviews[indexPath.row - 1]
            
            let user = review["author"] as! PFUser
            cell.usernameLabel.text = user.username
            cell.userReviewLabel.text = (review["text"] as! String)
            
            if user["profileImage"] != nil {
                
                let imageFile = user["profileImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                cell.userProfileImage.af.setImage(withURL: url)
                
            } else {
                
                cell.userProfileImage.image = UIImage(named: "default_profile_image")
                
            }
            
            cell.userProfileImage.layer.masksToBounds = true
            cell.userProfileImage.layer.cornerRadius = cell.userProfileImage.bounds.width / 2
            cell.userProfileImage.layer.borderWidth = 2
            cell.userProfileImage.layer.borderColor = UIColor.black.cgColor
            cell.userProfileImage.clipsToBounds = true
            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            showsReviewBar = true
            becomeFirstResponder()
            reviewBar.inputTextView.becomeFirstResponder()
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
