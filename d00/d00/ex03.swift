//
//  ex03.swift
//  d00
//
//  Created by Morgane DUBUS on 03/25/19.
//  Copyright © 2018 Morgane DUBUS. All rights reserved.
//

import UIKit

class ex03: UIViewController {
    
    @IBOutlet weak var result: UILabel!
    
    var nb1 = ""
    var nb2 = ""
    var oper = ""
    var res = ""
    
    @IBAction func getNumber(_ sender: UIButton) {
        print("Button " + sender.currentTitle! + " pressed !")
        if (oper == "") {
            if (res == "") {
                nb1 = nb1 + sender.currentTitle!
            }
            else {
                nb1 = sender.currentTitle!
                res = ""
            }
        }
        else {
            nb2 = nb2 + sender.currentTitle!
        }
        result.text = nb1 + oper + nb2
    }
    
    @IBAction func getOperator(_ sender: UIButton) {
        print("Button " + sender.currentTitle! + " pressed !")
        if (nb1 == ""){
            nb2 = ""
            oper = ""
            result.text = "Error"
        }
        else {
            oper = sender.currentTitle!
            result.text = nb1 + oper + nb2
        }
        
    }
    
    
    @IBAction func action(_ sender: UIButton) {
        print("Button " + sender.currentTitle! + " pressed !")
        if (sender.currentTitle == "AC") {
            nb1 = ""
            nb2 = ""
            oper = ""
            result.text = "0"
        }
        else if (sender.currentTitle == "NEG"){
            if (nb1 != "" && nb2 == "") {
                nb1 = String(Double(nb1)! * -1)
                result.text = nb1 + oper + nb2
            }
            else if (nb2 != "") {
                nb2 = String(Double(nb2)! * -1)
                result.text = nb1 + oper + nb2
            }
        }
    }
    
    @IBAction func getResult(_ sender: UIButton) {
        print("Button = pressed !")
        if (nb1 != "" && nb2 != "") {
            switch oper {
            case "+" :
                nb1 = String((Double(nb1)!) + (Double(nb2)!))
                result.text = nb1
            case "-" :
                nb1 = String((Double(nb1)!) - (Double(nb2)!))
                result.text = nb1
            case "*" :
                nb1 = String((Double(nb1)!) * (Double(nb2)!))
                result.text = nb1
            case "/" :
                if (nb2 == "0"){
                    nb1 = ""
                    result.text = "Error"
                }
                else{
                    nb1 = String((Double(nb1)!) / (Double(nb2)!))
                    result.text = nb1
                }
            default:
                break
            }
            res = nb1
            oper = ""
            nb2 = ""
        }
    }

    override func viewDidLoad() {
        result.text = "0"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
