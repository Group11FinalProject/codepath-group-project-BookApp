//
//  HomeScreenViewController.swift
//  Read and Tell
//
//  Created by PS101k on 10/26/22.
//

import UIKit
import AlamofireImage

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    var books = [[String:Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        
        let layout = bookCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=iz8MAMr5DnmAbPApq1UYPyrGinGYebIP")!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                let task = session.dataTask(with: request) { (data, response, error) in
                     // This will run when the network request returns
                     if let error = error {
                         print(error.localizedDescription)
                     } else if let data = data {
                         let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                         
                         let results = dataDictionary["results"] as! [String:Any]
                         let categoryLists = results["lists"] as! [Any]
                         let firstCategory = categoryLists[0] as! [String:Any]
                         self.books = firstCategory["books"] as! [[String:Any]]
                         
                         self.bookCollectionView.reloadData()
                         //print(dataDictionary)
                     }
                }
                task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "BookGridCell", for: indexPath) as! BookGridCell
       
        let book = books[indexPath.item]
               
        let bookTitle = book["title"] as! String
        cell.bookTitleLabel.text = bookTitle
        
        let bookImage = book["book_image"] as! String
        let bookImageUrl = URL(string: bookImage)
        cell.bookCoverImage.af.setImage(withURL: bookImageUrl!)
        
        return cell
    }
    
}

