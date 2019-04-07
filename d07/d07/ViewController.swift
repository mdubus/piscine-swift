//
//  ViewController.swift
//  d07
//
//  Created by Morgane DUBUS on 3/28/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit



class ViewController: UIViewController, APIRecastDelegate, APIForecastDelegate {
    
    var lat:Float = 0.0
    var long: Float = 0.0
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    func retrieveMeteo(answer: String) {
        DispatchQueue.main.async {
            self.label.text = answer
        }
    }
    
    func retrieveCoords(lat: Float, long: Float) {
        self.lat = lat
        self.long = long
    }
    
    func manageError(error: String) {
        
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        self.label.text = "Error"
    }
    
    @IBAction func submitRequest(_ sender: Any) {
        
        let initialQuestion = inputText.text?.trimmingCharacters(in: .whitespaces)
        guard let question = initialQuestion, question.isEmpty == false, question.count < 512 else { manageError(error: "Please provide a question"  );return }
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        
        group.enter()
        let recastController = APIRecastController(delegate: self)
        recastController.getBotAnswer(question: question, group:group)
        
        group.notify(queue:queue) {
            let forecastController = APIForecastController(delegate: self)
            forecastController.getMeteo(self.lat, self.long)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.layer.borderWidth = 0.5
        inputText.layer.cornerRadius = 5.0
    }
}
