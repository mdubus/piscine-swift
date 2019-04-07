//
//  DeathsTableViewCell.swift
//  d02
//
//  Created by Morgane DUBUS on 27/03/19.
//  Copyright © 2018 Morgane DUBUS. All rights reserved.
//

import UIKit

class DeathsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var deathcription: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var death:(String, String, String)? {
        didSet {
            if let d = death {
                name?.text = d.0
                deathcription?.text = d.1
                date?.text = d.2
            }
        }
    }

    
}
