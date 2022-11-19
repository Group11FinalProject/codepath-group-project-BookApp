//
//  MyFriendsViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/19/22.
//

import UIKit
import Parse
import AlamofireImage

class MyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myFriendsTableView: UITableView!
    @IBOutlet weak var emptyTableView: UIView!
    
    var friends = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyTableView.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        title = "My Friends"
        
        myFriendsTableView.delegate = self
        myFriendsTableView.dataSource = self
        
        handleEmptyView()
    }
    
    func handleEmptyView() {
        myFriendsTableView.reloadData()
        
        if (friends.count == 0) {
            myFriendsTableView.backgroundView = emptyTableView
        } else {
            myFriendsTableView.backgroundView = nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myFriendsTableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        
        cell.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        return cell
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
