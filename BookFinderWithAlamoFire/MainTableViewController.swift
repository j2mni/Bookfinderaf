//
//  MainTableViewController.swift
//  BookFinderWithAlamoFire
//
//  Created by lsy on 2022/11/03.
//

import UIKit
import Alamofire
import Kingfisher
import ProgressHUD

class MainTableViewController: UITableViewController {
    let apikey = "4cae53176045f8acd298a788ea85b153"
    var books:[Book] = []
    var page = 1
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        search(with: "가을", at: 1)
    }
    func search(with query:String?, at page:Int) {
        guard let query = query else {return}
        ProgressHUD.show("검색중...")
        let str = "https://dapi.kakao.com/v3/search/book"
        let params:Parameters = ["query":query,"page":page]
        let headers:HTTPHeaders = ["Authorization":"KakaoAK \(apikey)"]
        let alamo = AF.request(str, method: .get, parameters: params, headers: headers)
        
        alamo.responseDecodable(of: Result.self) { response in
            guard let root = response.value else {return}
            self.books = root.documents
            print(self.books)
            self.tableView.reloadData()
            ProgressHUD.showSucceed()
            
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath) as? BookCell else {fatalError()}
        let book = self.books[indexPath.row]
        let url = URL(string: book.thumbnail)
        cell.thumnail.kf.setImage(with: url)
        cell.lbllabel.text = book.title
        cell.Button.tag = indexPath.row
        cell.Button.addTarget(self, action: #selector(buttonClicked(sender: )), for: .touchUpInside)
        cell.sw.tag = indexPath.row
        cell.sw.addTarget(self, action: #selector(swValueChanged(sender: )), for: .valueChanged)
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath)
//        let book = self.books[indexPath.row]
//        let imageView = cell.viewWithTag(1) as? UIImageView
//        let url = URL(string: book.thumbnail)
//        imageView?.kf.setImage(with: url)
//
//        let lblView = cell.viewWithTag(2) as? UILabel
//        lblView?.text = book.title

//        return cell
    }
    @objc func buttonClicked(sender:UIButton) {
        let index = sender.tag
        let book = self.books[index]
        print(book.title)
    }
    @objc func swValueChanged(sender:UISwitch) {
        let index = sender.tag
        let book = self.books[index]
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        print(book.title)
    }
}
extension MainTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(with: searchBar.text, at: 1)
    }
}
