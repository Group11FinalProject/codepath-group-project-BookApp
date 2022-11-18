//
//  EditProfileViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 11/14/22.
//

import UIKit
import Parse
import AlamofireImage

class EditProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var editProfileTableView: UITableView!
    //var profileImageCellInstance = ProfileImageCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editProfileTableView.dataSource = self
        editProfileTableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = editProfileTableView.dequeueReusableCell(withIdentifier: "profileImageCell") as! ProfileImageCell
            
            cell.profileImageView?.layer.masksToBounds = true
            cell.profileImageView?.layer.cornerRadius = (cell.profileImageView?.bounds.width)! / 2
            cell.profileImageView?.layer.borderWidth = 1
            cell.profileImageView?.layer.borderColor = UIColor.black.cgColor
            cell.profileImageView?.clipsToBounds = true
            
            return cell
        } else if indexPath.row == 1 {
            let cell = editProfileTableView.dequeueReusableCell(withIdentifier: "usernameCell") as! UsernameCell
            
            return cell
        } else if indexPath.row == 2 {
            let cell = editProfileTableView.dequeueReusableCell(withIdentifier: "nameCell") as! NameCell
            
            return cell
        } else {
            let cell = editProfileTableView.dequeueReusableCell(withIdentifier: "bioCell") as! BioCell
            
            return cell
        }
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
        
        let profileImageCell = editProfileTableView.dequeueReusableCell(withIdentifier: "profileImageCell") as! ProfileImageCell
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profileImageCell.profileImageView?.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
}
