//
//  ViewController.swift
//  d04
//
//  Created by Morgane DUBUS on 3/29/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

// Twitter API changed. Can only get the tweets of the 7 last days (free account).
// So we can get less or 100 tweets here

let KEY = "YouWontHaveMyKey"
let SECRET = "YouWontHaveMySecret"
let BEARER = ((KEY+":"+SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))


enum tokenError:Error {
    case noAccessToken
    case badResponse
}

class ViewController: UITableViewController, APITwitterDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var token = ""
    var tweets:[Tweet] = []
    var keyword = "ecole 42"
    
    @IBOutlet weak var search: UISearchBar!
    
    func displayTweets(tweets: [Tweet]) {
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func manageError(error: Error) {
        
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyword = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search for keyword : \(keyword)")
        DispatchQueue.main.async {
            let controller = APIController(delegate: self, token: self.token)
            controller.getTweets(keyword: self.keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            self.tableView.reloadData()
        }
        searchBar.endEditing(true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of tweets : \(tweets.count)")
        return self.tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " +  BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        
        let getToken = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            if let err = error {
                self.manageError(error: err)
            }
            else if let d = data {
                do {
                    if let dic:NSDictionary = try JSONSerialization.jsonObject(with: d) as? NSDictionary {
                        if let token = dic.value(forKey: "access_token") {
                            self.token = token as! String
                            
                            let controller = APIController(delegate: self, token: self.token)
                            
                            DispatchQueue.main.async {
                                controller.getTweets(keyword: self.keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
                            }
                        }
                        else {
                            self.manageError(error: tokenError.noAccessToken)
                        }
                    }
                    else {
                        self.manageError(error: tokenError.badResponse)
                    }
                }
                catch (let err) {
                    self.manageError(error: err)
                }
            }
        }
        getToken.resume()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
}
