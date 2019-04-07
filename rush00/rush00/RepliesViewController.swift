//
//  RepliesViewController.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class RepliesViewController: UITableViewController {
    
    var messageID:Int?
    var replies:[Message] = []
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.replies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell") as! ReplyViewCell
        cell.message = self.replies[indexPath.row]
        return cell
    }
    
    @IBAction func deleteReply(_ sender: Any) {
        
        guard let id = self.messageID else {return}
        
        let url = URL(string: "\(APIBASE)/messages/\(id)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("Bearer " + TOKEN, forHTTPHeaderField: "Authorization")
        
        
        let getData = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    guard let dataString = String(data: d, encoding: String.Encoding.utf8) else {return }
                    print(dataString)
                    if dataString.contains("\"error\":\"Access Denied\"")  {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        getData.resume()
        
    }
}
