//
//  TweetModel.swift
//  d04
//
//  Created by Morgane DUBUS on 3/29/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation

struct Tweet:CustomStringConvertible {
    let name: String
    let text: String
    let date: String
    
    var description: String {
        return "Name : \(name)\nDate: \(date)\nTweet : \(text)"
    }
}
