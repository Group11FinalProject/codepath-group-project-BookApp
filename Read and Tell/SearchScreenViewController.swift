//
//  SearchScreenViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 10/31/22.
//

import UIKit

class SearchScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    var searchedBooks = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        self.searchTableView.rowHeight = UITableView.automaticDimension
        self.searchTableView.estimatedRowHeight = 210
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=and-then-there-were-none&key=AIzaSyBPoICjs3B7XKBQ5ou-eo3n10pgNTecQG0")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                
                //Replace NSDictionary with NSArray
                self.searchedBooks = dataDictionary["items"] as! [NSDictionary]
                
                /*
                 for item in items {
                 //self.searchedBooks.append((item as? NSDictionary)!)
                 self.searchedBooks.append(item as NSDictionary)
                 }
                 */
                
                //self.searchedBooks = items
                self.searchTableView.reloadData()
                //print(self.searchedBooks)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "BookSearchCell") as! BookSearchCell
        let bookInfo = searchedBooks[indexPath.row]["volumeInfo"] as? NSDictionary
        
        cell.bookTitleLabel.text = bookInfo?["title"] as? String
        
        let yearString = bookInfo?["publishedDate"] as? String
        if yearString != nil {
            var yearSubString = yearString!.prefix(4)
            cell.releaseYearLabel.text = String(yearSubString)
        } else {
            cell.releaseYearLabel.text = ""
        }
        
        let authorArray = bookInfo?["authors"] as? NSArray
        cell.authorNameLabel.text = authorArray?[0] as? String ?? "N/A"
        
        let imageLinksArray = bookInfo?["imageLinks"] as? NSDictionary
        if imageLinksArray != nil {
            let bookCoverImage = imageLinksArray?["thumbnail"] as! String
            let bookCoverImageUrl = URL(string: bookCoverImage)
            cell.bookCoverImage.af.setImage(withURL: bookCoverImageUrl!)
        } else {
            cell.bookCoverImage.image = UIImage(named: "book_cover_unavailable")
        }
        
        return cell
    }
}
