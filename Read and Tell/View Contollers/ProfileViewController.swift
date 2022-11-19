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
    @IBOutlet weak var profileScrollViewView: UIView!
    
    @IBOutlet weak var profileScrollViewOtherView: UIView!
    let user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 170.0/255.0, green: 195.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        profileScrollViewView.backgroundColor = UIColor(red: 170.0/255.0, green: 195.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        profileScrollViewOtherView.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        title = "My Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.borderWidth = 7
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user["profileImage"] != nil {
            
            let imageFile = user["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profileImageView.af.setImage(withURL: url)
            
        } else {
            
            profileImageView.image = UIImage(named: "default_profile_image")
            
        }
        
        nameDisplay.text = user["fullName"] as? String ?? "Your name goes here"
        usernameDisplay.text = "@" + user.username!
        bioDisplay.text = user["bio"] as? String ?? "Tell us about yourself"
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
