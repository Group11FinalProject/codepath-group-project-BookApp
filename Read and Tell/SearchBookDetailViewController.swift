//
//  SearchBookDetailViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 11/3/22.
//

import UIKit

class SearchBookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    
    
    @IBOutlet weak var bookTitleOutlet: UILabel!
    
    
    @IBOutlet weak var bookAuthorOutlet: UILabel!
    
    
    var book: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
