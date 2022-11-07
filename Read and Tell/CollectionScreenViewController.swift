//
//  CollectionScreenViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 10/31/22.
//

import UIKit
import AlamofireImage
import Parse

class CollectionScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myBooksCollectionView: UICollectionView!
    var myBooks = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        
        myBooksCollectionView.delegate = self
        myBooksCollectionView.dataSource = self
        
        self.myBooks = user?["bookCollection"] as! [PFObject]

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myBooksCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBooks.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = PFUser.current()!
        //let myBookCollection = user["bookCollection"]
        
       
        
        let cell = myBooksCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionGridCell", for: indexPath) as! CollectionGridCell
        
        let imageLinksArray = user["imageLinks"] as? NSDictionary
        if imageLinksArray != nil {
            
            let bookCoverImage = imageLinksArray?["thumbnail"] as! String
            let bookCoverImageUrl = URL(string: bookCoverImage)
            cell.bookCoverImage.af.setImage(withURL: bookCoverImageUrl!)
            
        } else {
            cell.bookCoverImage.image = UIImage(named: "book_cover_unavailable")
        }
        
        /*
        
        // Configure the cell
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false //<-
        
        /*
        cell.bookCoverImage.af.setImage(UIImage(named: "and then there were none"), for: UIControl.State.normal)
        */
         
        cell.bookCoverImage.image = UIImage(named: "and then there were none")
        */
        return cell
         
         
    }
}
