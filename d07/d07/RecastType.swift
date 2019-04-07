//
//  RecastType.swift
//  d07
//
//  Created by Morgane DUBUS on 3/29/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation

struct RecastType: Codable {
    var message: String?
    var results: Result?
}

struct Result: Codable {
    var entities: Entities?
}

struct Entities: Codable {
    var location: [Location]?
}

struct Location:Codable {
    var lng: Double?
    var lat: Double?
}
