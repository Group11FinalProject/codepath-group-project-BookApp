//
//  LoginViewController.swift
//  Read and Tell
//
//  Created by Dawa Sonam on 11/2/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameText: CustomTextField!
    
    @IBOutlet weak var passwordText: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signupSegue", sender: nil)
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
