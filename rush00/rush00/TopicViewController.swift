//
//  TopicViewController.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit


class TopicViewController: UITableViewController {
    
    var results:[Topic] = []
    
    func getTopics() {
        let url = URL(string: "\(APIBASE)/topics.json/?per_page=100")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + TOKEN, forHTTPHeaderField: "Authorization")
        
        print("***********************")
        print("TOKEN = \(TOKEN)")
        print("***********************")
        
        let getData = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    self.results = try jsonDecoder.decode([Topic].self, from: d)
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
    

    
    @IBAction func logout(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLoginWithSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "topicDetail") {
            if  let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! MessageViewController
                destVC.id = self.results[indexPath.row].id
                destVC.topic = self.results[indexPath.row]
                print(self.results[indexPath.row].message.content)//test modif
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
        self.getTopics()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! topicCell
        cell.topic = self.results[indexPath.row]
        return cell
    }
}
