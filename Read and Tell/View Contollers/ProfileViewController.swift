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
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        ProfileImageView.layer.masksToBounds = true
        ProfileImageView.layer.cornerRadius = ProfileImageView.bounds.width / 2
        ProfileImageView.layer.borderWidth = 1
        ProfileImageView.layer.borderColor = UIColor.black.cgColor
        ProfileImageView.clipsToBounds = true
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
}
