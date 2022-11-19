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
        
        
        view.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        signupUsernameText.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        
        signupPasswordText.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        
        emailText.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
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
    
    @IBAction func backToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpToLogin", sender: nil)
        
        
    }
    
    //When User swipes down on the screen, keyboard gets dismissed
    @IBAction func swipeToDismiss(_ sender: Any) {
        signupUsernameText.resignFirstResponder()
        signupPasswordText.resignFirstResponder()
        emailText.resignFirstResponder()
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
