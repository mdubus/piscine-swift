//
//  TweetCell.swift
//  d04
//
//  Created by Morgane DUBUS on 3/29/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    var tweet:Tweet? {
        didSet {
            if let t = tweet {
                name.text = t.name
                date.text = t.date
                tweetContent.text = t.text
                
                tweetContent.sizeToFit()
            }
        }
    }
}
