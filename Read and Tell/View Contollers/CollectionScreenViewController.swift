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
    let user = PFUser.current()!
    var myBooks = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myBooksCollectionView.backgroundColor = UIColor(red: 236.0/255.0, green: 226.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        
        title = "My Collection"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        myBooksCollectionView.delegate = self
        myBooksCollectionView.dataSource = self
        
        myBooksCollectionView?.frame = view.bounds
        
        let layout = myBooksCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width - 10, height: (width * 3 / 2) - 10)
        
        //layout.itemSize = CGSize(width: 200 - 30, height: 300)
        
        //Unhandled error. Nil value when user hasn't saved any books but tries to go to collection tab
        //self.myBooks = user?["bookCollection"] as! [PFObject]
        
        /*
         //self.myBooks = user?["bookCollection"] as! [PFObject]
         
         if myBooks == nil { (success, error) in
         if(success) {
         print("book saved to collection")
         }
         else {
         print("book not saved")
         }
         }
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Books")
        query.whereKey("user", equalTo: user)
        
        query.findObjectsInBackground { (myBooks, error) in
            if myBooks != nil {
                self.myBooks = myBooks!
                self.myBooksCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBooks.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let myBookCollection = user["bookCollection"]
        let cell = myBooksCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionGridCell", for: indexPath) as! CollectionGridCell
        
        let book = myBooks[indexPath.item]
        
        let bookCoverImage = book["imageLink"] as! String
        let bookCoverImageUrl = URL(string: bookCoverImage)
        cell.bookCoverImage.af.setImage(withURL: bookCoverImageUrl!)
        
        // Configure the cell
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false //<-
        
        return cell
    }
}
