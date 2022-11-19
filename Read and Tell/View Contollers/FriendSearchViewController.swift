//
//  FriendSearchViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/19/22.
//

import UIKit
import Parse

class FriendSearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var friendSearchTableView: UITableView!
    
    var users = [PFObject]()
    var searchController: UISearchController! // instantiate a search bar controller
    var searchResults = [PFObject]()  // declare an empty array to store search bar results
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendSearchTableView.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        searchController = UISearchController(searchResultsController: nil)
        friendSearchTableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search by name or username"
        
        friendSearchTableView.delegate = self
        friendSearchTableView.dataSource = self
        
        friendSearchTableView.rowHeight = 100
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFUser.query()
        query?.includeKeys(["username", "fullName", "profileImage"])
        //query.limit = 10
        
        query?.findObjectsInBackground { (users, error) in
            if users != nil {
                self.users = users!
                self.friendSearchTableView.reloadData()
                print(self.users)
            }
        }
        //self.users = (query?.findObjects())!
    }
    
    func filterSearch(_ searchText: String) {
        searchResults = users.filter({ (user:(PFObject)) -> Bool in
            let usernameMatch = (user["username"]! as AnyObject).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let nameMatch = (user["fullName"]! as AnyObject).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return usernameMatch != nil || nameMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterSearch(searchText)
            friendSearchTableView.reloadData()  // replace current table view with search results table view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = friendSearchTableView.dequeueReusableCell(withIdentifier: "friendSearchCell") as! FriendSearchCell
        
        cell.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        let username = user["username"] as! String
        cell.usernameLabel.text = "@" + username
        
        let name = user["fullName"] as! String
        if (name == "Your name goes here") {
            cell.nameLabel.text = ""
        } else {
            cell.nameLabel.text = name
        }
        
        if (user["profileImage"] != nil) {
            let imageFile = user["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.profileImageView.af.setImage(withURL: url)
        } else {
            cell.profileImageView.image = UIImage(named: "default_profile_image")
        }
        
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
