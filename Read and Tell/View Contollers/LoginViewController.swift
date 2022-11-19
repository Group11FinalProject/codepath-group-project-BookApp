//
//  LoginViewController.swift
//  Read and Tell
//
//  Created by Dawa Sonam on 11/2/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    //UITextFieldDelegate
    
    
    @IBOutlet weak var usernameText: CustomTextField!
    @IBOutlet weak var passwordText: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        usernameText.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        passwordText.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        
        //usernameText.delegate = self
        //passwordText.delegate = self
        
    }
    
    /*
    func textField(_ textField: UITextField, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    */
    
    //User Logs into their account and takes them to the Home Screen
    @IBAction func loginButton(_ sender: Any) {
        let username = usernameText.text!
        let password = passwordText.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: (error?.localizedDescription)")
            }
        }
        
    }
    
    //Once clicked, takes User to Sign Up Screen to create a new account
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    //When User swipes down on the screen, keyboard gets dismissed
    @IBAction func swipeToDismiss(_ sender: Any) {
        usernameText.resignFirstResponder()
        passwordText.resignFirstResponder()
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
