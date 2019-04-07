//
//  ReplyViewCell.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//
import Foundation
import UIKit

class ReplyViewCell: UITableViewCell {
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    
    var message:Message? {
        didSet {
            if let m = message {
                author.text = m.author.login
                date.text = formatDate(date: m.created_at)
                content.text = m.content
            }
        }
    }
}


