//
//  TopicCell.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class topicCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var author: UILabel!
    
    var topic:Topic? {
        didSet {
            if let t = topic {
                name.text = t.name
                date.text = formatDate(date: t.created_at)
                author.text = t.author.login
            }
        }
    }
}
