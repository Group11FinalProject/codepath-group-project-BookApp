//
//  SearchScreenViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 10/31/22.
//

import UIKit

class SearchScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    var searchedBooks = [NSArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=and-then-there-were-none&key=AIzaSyBPoICjs3B7XKBQ5ou-eo3n10pgNTecQG0")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                let items = dataDictionary["items"] as! NSArray
                //self.searchedBooks = items as? [NSArray]
                /*
                for item in items {
                    self.searchedBooks.append(item as! NSArray)
                }
                 
                 */
//                self.searchedBooks = itemElement["volumeInfo"] as? [[String:Any]] ?? []
//                self.seachTableView.reloadData()
                print(items[0])
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "BookSearchCell") as! BookSearchCell
        
        return cell
    }
}
