//
//  SearchScreenViewController.swift
//  Read and Tell
//
//  Created by Elaine Luzung on 10/31/22.
//

import UIKit
import AlamofireImage
import MessageInputBar

class SearchScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputBarDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    var searchedBooks = [NSDictionary]()
    let searchBar = MessageInputBar()
    var showsSearchBar = false
    let cell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        self.searchTableView.rowHeight = UITableView.automaticDimension
        self.searchTableView.estimatedRowHeight = 210
        
        searchBar.inputTextView.placeholder = "Search any book by title, author or genre!"
        searchBar.sendButton.image = UIImage(systemName: "magnifyingglass")
        searchBar.delegate = self
        
        searchTableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTableView.reloadData()
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        searchBar.inputTextView.text = nil
        showsSearchBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return searchBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsSearchBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith searchInput: String) {
        let modifiedResultsTextString = searchInput.replacingOccurrences(of: " ", with: "-")
        
        findBooks(input: modifiedResultsTextString)
        searchTableView.reloadData()
        
        //Clear and dismiss the input bar
        searchBar.inputTextView.text = nil
        showsSearchBar = false
        becomeFirstResponder()
        searchBar.inputTextView.resignFirstResponder()
    }
    
    func findBooks(input: String) {
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(input)&key=AIzaSyBPoICjs3B7XKBQ5ou-eo3n10pgNTecQG0")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                self.searchedBooks.removeAll()
                self.searchedBooks = dataDictionary["items"] as! [NSDictionary]
                

                self.searchTableView.reloadData()
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = searchTableView.dequeueReusableCell(withIdentifier: "searchBarCell")!
            return cell
        } else if indexPath.row <= searchedBooks.count {
            let cell = searchTableView.dequeueReusableCell(withIdentifier: "BookSearchCell") as! BookSearchCell
            let bookInfo = searchedBooks[indexPath.row - 1]["volumeInfo"] as? NSDictionary
            
            cell.bookTitleLabel.text = bookInfo?["title"] as? String
            
            let yearString = bookInfo?["publishedDate"] as? String
            if yearString != nil {
                let yearSubString = yearString!.prefix(4)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            showsSearchBar = true
            becomeFirstResponder()
            searchBar.inputTextView.becomeFirstResponder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = searchTableView.indexPath(for: cell)!
        let book = searchedBooks[indexPath.row - 1]["volumeInfo"] as! NSDictionary
        
        let detailsViewController = segue.destination as! SearchBookDetailViewController
        detailsViewController.book = book
        
        searchTableView.deselectRow(at: indexPath, animated: true)
    }
}
