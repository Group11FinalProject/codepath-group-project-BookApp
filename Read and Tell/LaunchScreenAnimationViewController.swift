//
//  LaunchScreenAnimationViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/19/22.
//

import UIKit
import Lottie

class LaunchScreenAnimationViewController: UIViewController {
    
    let animationView = LottieAnimationView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        
        setupAnimation()
       
        

        // Do any additional setup after loading the view.
    }
    
    private func setupAnimation() {
        
        animationView.animation = LottieAnimation.named("87676-teaching-study-two-girls-with-books-and-a-skateboard")
        animationView.frame = CGRect(x: 0, y: 100, width: 400, height: 400)
        animationView.center = view.center
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        //print("This should work")
        //self.performSegue(withIdentifier: "splashToLogin", sender: nil)
        
    }
    
    
    @IBAction func beginButton(_ sender: Any) {
        self.performSegue(withIdentifier: "splashToLogin", sender: nil)
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
