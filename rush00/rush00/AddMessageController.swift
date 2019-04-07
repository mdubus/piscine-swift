//
//  AddMessageController.swift
//  rush00
//
//  Created by Sylvain BONNEFON on 3/31/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class AddMessageController: UIViewController  {
    
    var currentTopic = ""

    @IBOutlet weak var messageField: UITextView!
    
    @IBAction func addMessage(_ sender: Any) {
        
        if messageField.text?.isEmpty == true {
            messageField.layer.borderWidth = 1.0
            messageField.layer.borderColor = UIColor.red.cgColor
            return
        }
        else {
            messageField.layer.borderWidth = 0.0
        }
        
        
        let url = URL(string: "\(APIBASE)/topics/\(currentTopic)/messages")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Bearer " + TOKEN, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //        POST /v2/messages
        //            {
        //                "message": {
        //                    "author_id": "6",
        //                    "content": "Hello world",
        //                    "messageable_id": "7",
        //                    "messageable_type": "Topic"
        //                }
        //        }
        
        let jsonEncoder = JSONEncoder()
        let message = APIMessageAttr(content: messageField.text, messageable_id: "1", messageable_type: "Topic")
        
        //        let topicData = NewTopic(cursus_ids: ["1"], kind: "normal", language_id: "1", messages_attributes: [messageAttributes], name: topicTitle.text!, tag_ids: ["578", "574"])
        //
        //        let topic = AddTopic(topic: topicData)
        guard let newMessage = try? jsonEncoder.encode(message) else { return }
        
        
        request.httpBody = newMessage
        
        let postTopic = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
             print(response)
            
            if let err = error {
                print(err)
            }
            else if let data = data {
                do {
                    print(String(data: data, encoding: String.Encoding.utf8) as Any)
                    // depop view when topic is posted
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        postTopic.resume()
     
        
    }
}



