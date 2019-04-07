//
//  ex01.swift
//  d00
//
//  Created by Morgane DUBUS on 03/25/19.
//  Copyright © 2018 Morgane DUBUS. All rights reserved.
//

import UIKit

class ex01: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func changeLabelTitle(_ sender: UIButton) {
        label.text = "Hello World !"
    }
    
    @IBAction func resetLabelTitle(_ sender: UIButton) {
        label.text = "Label"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
