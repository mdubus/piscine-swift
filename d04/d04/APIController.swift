//
//  APIController.swift
//  d04
//
//  Created by Morgane DUBUS on 3/29/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation

protocol APITwitterDelegate:class {
    func displayTweets(tweets: [Tweet])
    func manageError(error: Error)
}

enum APIError : Error {
    case noResultForKeyword
    case noUserForTweet
    case noUserNameForUser
    case noDateForTweet
    case noTextForTweet
    case noDateToConvert
    case couldNotConvertTwitterDate
}

class APIController {
    
    weak var delegate: APITwitterDelegate?
    let token: String
    
    init(delegate:APITwitterDelegate?, token:String) {
        self.delegate = delegate
        self.token = token
    }
    
    func getFormatedDate(date: String) -> String{
        var formatedDate = ""
        if date.isEmpty {
             self.delegate?.manageError(error: APIError.noDateToConvert)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
        if let localDate = dateFormatter.date(from: date) {
            dateFormatter.locale =  Locale(identifier: "FR-fr")
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            formatedDate = dateFormatter.string(from: localDate)
        }
        
        return formatedDate
    }
    
    func getTweets(keyword:String){
        var tweets:[Tweet] = []
        
        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q="+keyword+"&count=100&result_type=recent&lang=fr&tweet_mode=extended")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let getData = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            if let err = error {
                self.delegate?.manageError(error: err)
            }
            else if let d = data {
                do {
                    if let dic:NSDictionary = try JSONSerialization.jsonObject(with: d) as? NSDictionary {
                        
                        if let statuses: [NSDictionary] = dic.value(forKey: "statuses") as? [NSDictionary] {
                                                        
                            var tweetIterator = statuses.makeIterator()
                            while let tweet = tweetIterator.next() {
                                print(tweet)
                                guard let user: NSDictionary = tweet["user"] as? NSDictionary else {
                                    self.delegate?.manageError(error: APIError.noUserForTweet)
                                    return
                                }
                                guard let userName:String = user["name"] as? String else {
                                    self.delegate?.manageError(error: APIError.noUserNameForUser)
                                    return
                                }
                                guard let date:String = tweet["created_at"] as? String else {
                                    self.delegate?.manageError(error: APIError.noDateForTweet)
                                    return
                                }
                                guard let text:String = tweet["full_text"] as? String else {
                                    self.delegate?.manageError(error: APIError.noTextForTweet)
                                    return
                                }
                                let formatedDate =  self.getFormatedDate(date: date)
                                if formatedDate.isEmpty {
                                    self.delegate?.manageError(error: APIError.couldNotConvertTwitterDate)
                                }
                                tweets.append(Tweet(name:userName, text:text, date:formatedDate))
                            }
                            self.delegate?.displayTweets(tweets: tweets)
                        }
                        else {
                            self.delegate?.manageError(error: APIError.noResultForKeyword)
                        }
                    }
                    else {
                        self.delegate?.manageError(error: tokenError.badResponse)
                    }
                }
                catch (let err) {
                    self.delegate?.manageError(error: err)
                }
            }
        }
        getData.resume()
    }
}
