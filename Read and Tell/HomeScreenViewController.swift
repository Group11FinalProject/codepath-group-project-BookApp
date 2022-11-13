//
//  HomeScreenViewController.swift
//  Read and Tell
//
//  Created by Joseph Siggia on 10/26/22.
//

import UIKit
import AlamofireImage

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var books = [NSDictionary]()
    var categoryListsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        /*
        let layout = bookCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        *
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        */
        
        /*
        bookCollectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        */
        
        view.addSubview(bookCollectionView!)
        bookAPICall()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bookCollectionView?.frame = view.bounds
        
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 5
        //let width = (view.frame.size.width - flowLayout.minimumInteritemSpacing)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
        flowLayout.itemSize = CGSize(width: 200-20, height: 345)
    }
    
    func bookAPICall () {
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
                self.categoryListsCount = categoryLists.count

                /*
                for index in categoryLists.indices {
                    let categoryElement = categoryLists[index]
                    self.books.append(contentsOf: categoryElement["books"] as! [NSDictionary])
                }
                */
                
                self.books = categoryLists
                self.bookCollectionView.reloadData()
            }
        }
        task.resume()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryListsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "BookGridCell", for: indexPath) as! BookGridCell
        let bookCategory = books[indexPath.section]
        let bookList = bookCategory["books"] as! [NSDictionary]
        let book = bookList[indexPath.item]
        
        let bookTitle = book["title"] as! String
        cell.bookTitleLabel?.text = bookTitle
        
        let bookImage = book["book_image"] as! String
        let bookImageUrl = URL(string: bookImage)
        cell.bookCoverImage.af.setImage(withURL: bookImageUrl!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = bookCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        
        let bookCategory = books[indexPath.section]
        header.categoryTitleLabel.text = bookCategory["list_name"] as? String
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        //flowLayout.minimumLineSpacing = 5
        //let width = (view.frame.size.width - flowLayout.minimumLineSpacing) / 2
        return CGSize(width: view.frame.size.width, height: 105)
        //height: 105
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = bookCollectionView.indexPath(for: cell)!
        let bookCategory = books[indexPath.section]
        let bookList = bookCategory["books"] as! [NSDictionary]
        let book = bookList[indexPath.item]
        let featuredDetailsViewController = segue.destination as! FeaturedBookDetailViewController
        featuredDetailsViewController.book = book
        
        bookCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

