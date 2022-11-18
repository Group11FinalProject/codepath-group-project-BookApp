//
//  ProfileViewController.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/6/22.
//

import UIKit
import Parse
import SwiftUI

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameDisplay: UILabel!
    @IBOutlet weak var usernameDisplay: UILabel!
    @IBOutlet weak var bioDisplay: UILabel!
    
    let user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        nameDisplay.text = user["fullName"] as! String
        usernameDisplay.text = "@" + user.username!
        bioDisplay.text = user["bio"] as! String
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.borderWidth = 7
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
    @IBAction func editProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "toEditProfile", sender: nil)
    }
}
