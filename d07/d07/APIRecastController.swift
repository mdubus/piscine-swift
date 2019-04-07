//
//  APIRecastController.swift
//  d07
//
//  Created by Morgane DUBUS on 3/29/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import sapcai

let recastURL = "https://api.cai.tools.sap/train/v2/request"

let recastToken = "YouWontHaveMyToken"

protocol APIRecastDelegate:class {
    func manageError(error:String)
    func retrieveCoords(lat: Float, long: Float)
}

class APIRecastController {
    weak var delegate: APIRecastDelegate?
    var bot : SapcaiClient?
    var lat: Float = 0.0
    var long: Float = 0.0
    
    init(delegate: APIRecastDelegate?) {
        guard let mydelegate = delegate else { return }
        self.delegate = mydelegate
    }
    
    func decodeData(_ response : Response) {
        guard let entities = response.entities, let locations = entities.locations else {self.delegate?.manageError(error: "Location doesn't exists"); return }
        self.lat = locations[0].lat
        self.long = locations[0].lng
        self.delegate?.retrieveCoords(lat: self.lat, long: self.long)
    }
    
    func throwError(error:Error) {
        self.delegate?.manageError(error: error.localizedDescription)
        return
    }
    
    func getBotAnswer(question:String, group:DispatchGroup) {
        self.bot = SapcaiClient(token:recastToken, language: "en")
        self.bot?.analyseText(question, successHandler: { (response) in
            self.decodeData(response)
            group.leave()
        }, failureHandle: throwError)
    }
}
