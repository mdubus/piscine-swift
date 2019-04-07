//
//  Shape.swift
//  d06
//
//  Created by Morgane DUBUS on 3/9/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

let DIMENSION = CGFloat(100)

let SQUARE = 0
let CIRCLE = 1
let colors = [
    UIColor.black,
    UIColor.blue,
    UIColor.brown,
    UIColor.cyan,
    UIColor.green,
    UIColor.magenta,
    UIColor.orange,
    UIColor.purple,
    UIColor.red,
    UIColor.yellow
]

class ShapeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        layer.cornerRadius = (arc4random_uniform(2) == CIRCLE) ? CGFloat(DIMENSION / 2) : 0
        backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
