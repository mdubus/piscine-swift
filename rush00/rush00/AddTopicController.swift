//
//  AddTopicController.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/31/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class AddTopicController: UIViewController  {
    
    
    @IBOutlet weak var topicTitle: UITextField!
    @IBOutlet weak var input: UITextView!
    
    @IBAction func addTopic(_ sender: Any) {
        
        
        if topicTitle.text?.isEmpty == true {
            topicTitle.layer.borderWidth = 1.0
            topicTitle.layer.borderColor = UIColor.red.cgColor
            return
        }
        else {
            topicTitle.layer.borderWidth = 0.0
        }
        
        if input.text.isEmpty == true  {
            input.layer.borderWidth = 1.0
            input.layer.borderColor = UIColor.red.cgColor
            return
        }
        else {
            input.layer.borderWidth = 0.0
        }
        
        let url = URL(string: "\(APIBASE)/topics.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Bearer " + TOKEN, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonEncoder = JSONEncoder()
        let messageAttributes = APIMessageAttr(content: input.text, messageable_id: "1", messageable_type: "Topic")
        
        let topicData = NewTopic(cursus_ids: ["1"], kind: "normal", language_id: "1", messages_attributes: [messageAttributes], name: topicTitle.text!, tag_ids: ["578", "574"])
        
        let topic = AddTopic(topic: topicData)
        guard let newTopic = try? jsonEncoder.encode(topic) else { return }
        
        
        request.httpBody = newTopic
        
            let postTopic = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                
                if let err = error {
                    print(err)
                }
                else if let data = data {
                    do {
                        print(String(data: data, encoding: String.Encoding.utf8) as Any)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                        // depop view when topic is posted
                      
                    }
                }
            }
        postTopic.resume()
        
    }
}

