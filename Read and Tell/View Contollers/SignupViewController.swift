//
//  SignupViewController.swift
//  Read and Tell
//
//  Created by Dawa Sonam on 11/2/22.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var emailText: CustomTextField!
    @IBOutlet weak var signupUsernameText: CustomTextField!
    @IBOutlet weak var signupPasswordText: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Lets User create a new account
    @IBAction func signupButton(_ sender: Any) {
        let user = PFUser()
        
        user.username = signupUsernameText.text
        user.password = signupPasswordText.text
        user.email = emailText.text
        user["bio"] = "Tell us about yourself!"
        user["fullName"] = "Your name goes here"
        
        let imageData = UIImage(named:"default_profile_image")?.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        user["profileImage"] = file
        
        //Saves User's information as a new User
        user.signUpInBackground{(success, error) in
            if success {
                self.performSegue(withIdentifier: "signupToHomeSegue", sender: nil) //Sends User to Home Screen after account was created
            }
            
            else {
                print("Error: \(error?.localizedDescription)")
            }
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
