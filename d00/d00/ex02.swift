//
//  ex02.swift
//  d00
//
//  Created by Morgane DUBUS on 03/25/19.
//  Copyright © 2018 Morgane DUBUS. All rights reserved.
//

import UIKit

class ex02: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    @IBAction func getNumber(_ sender: UIButton) {
        print("Button " + sender.currentTitle! + " pressed !")
        result.text = sender.currentTitle
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        print("Button " + sender.currentTitle! + " pressed !")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
