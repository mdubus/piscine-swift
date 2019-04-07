//
//  EditPostController.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/31/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class EditTopicController: UIViewController {
    var postID:String  = ""
    var topic: Topic!
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postContent: UITextView!
    
    override func viewDidLoad() {
        postTitle.text = topic?.name
        postContent.text = topic?.message.content.markdown
        print(self.postID)
    }
    
    @IBAction func updateTopic(_ sender: Any) {
        
        
        
        if postTitle.text?.isEmpty == true {
            postTitle.layer.borderWidth = 1.0
            postTitle.layer.borderColor = UIColor.red.cgColor
            return
        }
        else {
            postTitle.layer.borderWidth = 0.0
        }
        
        if postContent.text.isEmpty == true  {
            postContent.layer.borderWidth = 1.0
            postContent.layer.borderColor = UIColor.red.cgColor
            return
        }
        else {
            postContent.layer.borderWidth = 0.0
        }
        var updateId = String(topic.id)

        let url = URL(string: "\(APIBASE)/topics/\(updateId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("Bearer " + TOKEN, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()
        //let messageAttributes = APIMessageAttr(content: postContent.text, messageable_id: "1", messageable_type: "Topic")

       // let topicMessage = TopicMessage(content: )
        let topicContent = TopicMessageAt(content: postContent.text)
        let topicUpdate = TopicUpdateCompo(name: postTitle!.text!, message_attributes:topicContent /*, message: messageAttributes*/)
        let topicUpdateFull = TopicUpdate(topic: topicUpdate)
//
//

//
//
        guard let newTopic = try? jsonEncoder.encode(topicUpdateFull) else { return }
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
