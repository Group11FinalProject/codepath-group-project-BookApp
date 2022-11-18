//
//  DiscussionContentViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/9/22.
//

import UIKit
import Parse
import MessageInputBar

class DiscussionContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    
    @IBOutlet weak var discussionTableView: UITableView!
    
    var bookDiscussion: NSDictionary!
    var discussionPosts = [PFObject]()
    let discussionBar = MessageInputBar()
    var showsDiscussionBar = false
    let cell = UITableViewCell()
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRefreshControl.addTarget(self, action: #selector(onRefresh), for: UIControl.Event.valueChanged)
        
        discussionTableView.insertSubview(myRefreshControl, at: 0)
        
        discussionBar.inputTextView.placeholder = "What are your thoughts on the work?"
        discussionBar.sendButton.title = "Post"
        
        discussionBar.delegate = self
        discussionTableView.delegate = self
        discussionTableView.dataSource = self
        
        discussionTableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func onRefresh() {
        run(after: 1.5) {
            self.myRefreshControl.endRefreshing()
            self.discussionTableView.reloadData()
        }
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        discussionBar.inputTextView.text = nil
        showsDiscussionBar = false
        becomeFirstResponder()
        
    }
    
    override var inputAccessoryView: UIView? {
        return discussionBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsDiscussionBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let discussionPost = PFObject(className: "DiscussionPost")
        
        discussionPost["text"] = text
        discussionPost["author"] = PFUser.current()!
        discussionPost["title"] = bookDiscussion["title"]
        
        if bookDiscussion["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = bookDiscussion["industryIdentifiers"] as? [NSDictionary]
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            discussionPost["identifier"] = industryIndentifier
        } else {
            
            let industryIdentifier = bookDiscussion["primary_isbn10"] as! String
            discussionPost["identifier"] = industryIdentifier
        }

        discussionPost.saveInBackground { (success, error) in
            if (success) {
                print("discussion saved")
            } else {
                print("error saving discussion")
            }
        }
        
        discussionTableView.reloadData()
        
        discussionBar.inputTextView.text = nil
        showsDiscussionBar = false
        becomeFirstResponder()
        discussionBar.inputTextView.resignFirstResponder()
        
        viewDidAppear(true)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if bookDiscussion["industryIdentifiers"] != nil {
            
            let industryIdentifierArray = bookDiscussion["industryIdentifiers"] as? [NSDictionary]
            let industryIndentifier = industryIdentifierArray?[0]["identifier"] as! String
            
            let query = PFQuery(className: "DiscussionPost")
            query.whereKey("identifier", equalTo: industryIndentifier)
            query.includeKeys(["author", "text"])
            query.order(byDescending: "createdAt")
            query.limit = 10
            
            query.findObjectsInBackground { (discussionPosts, error) in
                if discussionPosts != nil {
                    self.discussionPosts = discussionPosts!
                    self.discussionTableView.reloadData()
                }
            }
        } else {
            
            let industryIdentifier = bookDiscussion["primary_isbn10"] as! String
            
            let query = PFQuery(className: "DiscussionPost")
            query.whereKey("identifier", equalTo: industryIdentifier)
            query.includeKeys(["author", "text"])
            query.order(byDescending: "createdAt")
            query.limit = 10
            
            query.findObjectsInBackground { (discussionPosts, error) in
                if discussionPosts != nil {
                    self.discussionPosts = discussionPosts!
                    self.discussionTableView.reloadData()
                }
            }
        }
 
        discussionTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussionPosts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = discussionTableView.dequeueReusableCell(withIdentifier: "AddDiscussionPostCell")!
            
            return cell
        } else if indexPath.row <= discussionPosts.count {
            discussionTableView.rowHeight = 150
            let cell = discussionTableView.dequeueReusableCell(withIdentifier: "DiscussionCell") as! DiscussionCell
            let discussionPost = discussionPosts[indexPath.row - 1]
            
            let user = discussionPost["author"] as! PFUser
            cell.discussionUserNameLabel.text = user.username
            cell.discussionUserTextLabel.text = (discussionPost["text"] as! String)
            
            if user["profileImage"] != nil {
                
                let imageFile = user["profileImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                cell.discussionUserProfileImageView.af.setImage(withURL: url)
                
            } else {
                
                cell.discussionUserProfileImageView.image = UIImage(named: "default_profile_image")
                
            }
            
            cell.discussionUserProfileImageView.layer.masksToBounds = true
            cell.discussionUserProfileImageView.layer.cornerRadius = cell.discussionUserProfileImageView.bounds.width / 2
            cell.discussionUserProfileImageView.layer.borderWidth = 3
            cell.discussionUserProfileImageView.layer.borderColor = UIColor.black.cgColor
            cell.discussionUserProfileImageView.clipsToBounds = true
            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            showsDiscussionBar = true
            becomeFirstResponder()
            discussionBar.inputTextView.becomeFirstResponder()
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
