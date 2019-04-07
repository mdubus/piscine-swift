//
//  MessageViewController.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class MessageViewController: UITableViewController {
 
    var id:Int?
    var topic: Topic?
    var results:[Message] = []
    
    override func viewWillAppear(_ animated: Bool) {
        guard let messageID = self.id else {return }
        print(messageID)
        
        let url = URL(string: "\(APIBASE)/topics/\(messageID)/messages")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + TOKEN, forHTTPHeaderField: "Authorization")

        
        let getData = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    self.results = try jsonDecoder.decode([Message].self, from: d)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        getData.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if (segue.identifier == "repliesDetail") {
            if  let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! RepliesViewController
                destVC.replies = self.results[indexPath.row].replies
                destVC.messageID = self.results[indexPath.row].id
            }
        }
        
        if (segue.identifier == "addResponseForTopic") {
            let destVC = segue.destination as! AddMessageController
            guard let postID = self.id else {return }
            destVC.currentTopic = String(postID)
        }
        
        if (segue.identifier == "editTopicSegue") {
            let destVC = segue.destination as! EditTopicController
            guard let postID = self.id else {return }
            destVC.postID = String(postID)
            destVC.topic = self.topic
            
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageViewCell
        cell.message = self.results[indexPath.row]
        return cell
    }
    
    
    @IBAction func deleteTopic(_ sender: Any) {
        
        guard let id = self.id else {return}
        print(id)
        
        let url = URL(string: "\(APIBASE)/topics/\(id).json")
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
