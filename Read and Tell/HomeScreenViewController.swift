//
//  HomeScreenViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 10/26/22.
//

import UIKit
import AlamofireImage

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    var books = [NSDictionary]()
    
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
                
                let results = dataDictionary["results"] as! NSDictionary
                let categoryLists = results["lists"] as! [NSDictionary]
                
                for index in categoryLists.indices {
                    let categoryElement = categoryLists[index]
                    self.books.append(contentsOf: categoryElement["books"] as! [NSDictionary])
                }
                
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
        //let imageWidth = book["book_image_width"] as! Int
        //let imageHeight = book["book_image_height"] as! Int
        //let size = CGSize(width: imageWidth, height: imageHeight)
        let bookImageUrl = URL(string: bookImage)
        /*
         if let data = try? Data(contentsOf: bookImageUrl!) {
         let image: UIImage = UIImage(data: data)!
         let scaledImage = image.af.imageAspectScaled(toFill: size)
         cell.bookCoverImage.image = scaledImage
         }
         */
        cell.bookCoverImage.af.setImage(withURL: bookImageUrl!)
        
        /*
         cell.addButtonTapAction = {
         self.performSegue(withIdentifier: "your segue", sender: self)
         }
         */
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = bookCollectionView.indexPath(for: cell)!
        let book = books[indexPath.item]
        let featuredDetailsViewController = segue.destination as! FeaturedBookDetailViewController
        featuredDetailsViewController.book = book
        
        bookCollectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

