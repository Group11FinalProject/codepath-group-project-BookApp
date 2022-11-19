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
        
        
        view.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        title = "Edit Profile"
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if user["profileImage"] != nil {
            
            let imageFile = user["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            editProfileImageView.af.setImage(withURL: url)
            
        } else {
            
            editProfileImageView.image = UIImage(named: "default_profile_image")
            
        }
        
        usernameInput.text = user.username
        nameInput.text = user["fullName"] as? String
        bioInput.text = user["bio"] as? String
        
        editProfileImageView.layer.masksToBounds = true
        editProfileImageView.layer.cornerRadius = editProfileImageView.bounds.width / 2
        editProfileImageView.layer.borderWidth = 2
        editProfileImageView.layer.borderColor = UIColor.black.cgColor
        editProfileImageView.clipsToBounds = true
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize (width: 250, height: 250)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        editProfileImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        //let controller = ProfileViewController()
        user.username = usernameInput.text
        user["fullName"] = nameInput.text
        user["bio"] = bioInput.text
        
        if user["profileImage"] != nil {
            let imageData = editProfileImageView.image!.pngData()
            let file = PFFileObject(name: "image.png", data: imageData!)
            user["profileImage"] = file
        } else {
            let imageData = UIImage(named:"default_profile_image")?.pngData()
            let file = PFFileObject(name: "image.png", data: imageData!)
            user["profileImage"] = file
        }
        
        user.saveInBackground { (success, error) in
            if success {
                print("saved!")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error!")
            }
        }
    }
}
