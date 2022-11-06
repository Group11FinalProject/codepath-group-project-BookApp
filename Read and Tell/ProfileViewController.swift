//
//  ProfileViewController.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/5/22.
//

import UIKit
import Foundation
import SwiftUI


class ProfileViewController: UIViewController {

    

    @IBOutlet weak var ProfilePicView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension ProfileViewController {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func setupNavigationItem() {
//        self.navigationItem.title = "Profile View Controller"
    }
}

@available(iOS 13.0, *)
struct ProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let profile = ProfileViewController()
        return UINavigationController(rootViewController: profile).previews
    }
}

@IBDesignable
class CircularImageCiew: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
