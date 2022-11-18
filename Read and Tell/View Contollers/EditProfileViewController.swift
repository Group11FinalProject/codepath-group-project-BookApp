//
//  EditProfileViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/14/22.
//

import UIKit
import Parse
import AlamofireImage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var editProfileImageView: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var bioInput: UITextView!
    let user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Profile"
        
        usernameInput.text = user.username
        nameInput.text = user["fullName"] as? String
        bioInput.text = user["bio"] as? String
        
    }
    
    @IBAction func selectPictureButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //picker.sourceType = .camera
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
    }
    
}
