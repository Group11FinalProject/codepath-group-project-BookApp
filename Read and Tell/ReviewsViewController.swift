//
//  ReviewsViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/4/22.
//

import UIKit
import MessageInputBar
import Parse

class ReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputBarDelegate {
    
    @IBOutlet weak var reviewTableView: UITableView!
    let reviewBar = MessageInputBar()
    var showsReviewBar = false
    var reviews = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewBar.inputTextView.placeholder = "Add a review..."
        reviewBar.sendButton.title = "Submit"
        
        reviewBar.delegate = self
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        reviewTableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith content: String) {
        //Create comment
        let review = PFObject(className: "Reviews")
        
        review["content"] = content
        review["author"] = PFUser.current()!

        reviewTableView.reloadData()
        
        //Clear and dismiss the input bar
        reviewBar.inputTextView.text = nil
        showsReviewBar = false
        becomeFirstResponder()
        reviewBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = reviews[indexPath.row + 1]
        
        if indexPath.row <= reviews.count {
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
            let user = review["author"] as! PFUser
            
            let reviewComment = review["content"] as! String
            
            return cell
        } else {
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "AddReviewCell")!
            
            return cell
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
