//
//  formatDate.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation

func formatDate(date: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let newDate = dateFormatter.date(from: date) else {return date}
    dateFormatter.locale =  Locale(identifier: "FR-fr")
    dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
    return dateFormatter.string(from: newDate)

}
