//
//  ProfileViewController.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/6/22.
//

import UIKit

import Parse

import SwiftUI

import AlamofireImage

class ProfileViewController: UIViewController {
    
        @IBOutlet weak var theContainer : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         SwiftUI imageView code
                let childView = UIHostingController(rootView: ProfileViewSetup())
                addChild(childView)
                childView.view.frame = theContainer.bounds
                theContainer.addSubview(childView.view)
    }
    
}

