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
    var newBook: PFObject?
    let cell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewBar.inputTextView.placeholder = "Add a review..."
        reviewBar.sendButton.image = UIImage(systemName: "pencil.line")
        
        reviewBar.delegate = self
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        reviewTableView.keyboardDismissMode = .interactive
        
        
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
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
        let bookCopyObject = PFObject(className: "Books")
        
        review["text"] = text
        review["author"] = PFUser.current()!
        review["book"] = bookCopyObject
        
        bookCopyObject["reviews"] = reviews
        
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Reviews")
        query.whereKey("book", equalTo: newBook)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            reviewTableView.rowHeight = 100
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "AddReviewCell")!
            
            return cell
        } else if indexPath.row <= reviews.count {
            reviewTableView.rowHeight = 150
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
            let review = reviews[indexPath.row - 1]
            
            let user = review["author"] as! PFUser
            cell.usernameLabel.text = user.username
            cell.userReviewLabel.text = (review["text"] as! String)
            
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
