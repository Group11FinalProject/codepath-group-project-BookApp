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
    
    override var inputAccessoryView: UIView? {
        return reviewBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsReviewBar
    }
    
    
    
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
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let review = PFObject(className: "Reviews")
        
        review["text"] = text
        review["author"] = PFUser.current()!
        
        review.saveInBackground { (success, error) in
            if (success) {
                print("reviewSaved")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row < reviews.count) {
            reviewTableView.rowHeight = 150
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
            
            return cell
            
        }
        
        else {
            reviewTableView.rowHeight = 100
            let cell = reviewTableView.dequeueReusableCell(withIdentifier: "AddReviewCell")!
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == reviews.count) {
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
