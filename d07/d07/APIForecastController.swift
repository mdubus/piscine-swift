//
//  APIDarkskyController.swift
//  d07
//
//  Created by Morgane DUBUS on 4/1/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import ForecastIO

let forecastURL = "https://api.darksky.net/forecast"

let forecastToken = "YouWontHaveMyToken"

protocol APIForecastDelegate:class {
    func manageError(error:String)
    func retrieveMeteo(answer:String)
}

class APIForecastController {
    weak var delegate: APIForecastDelegate?
    let client = DarkSkyClient(apiKey: forecastToken)
    
    init(delegate: APIForecastDelegate?) {
        guard let mydelegate = delegate else { return }
        self.delegate = mydelegate
    }
    
    func getMeteo(_ lat:Float, _ long:Float) {
        client.language = .french
        client.getForecast(latitude: Double(lat), longitude: Double(long)) { result in
            switch result {
            case .success(let currentForecast, _):
                guard let meteo = currentForecast.currently?.summary else {self.delegate?.manageError(error: "unable to retrieve meteo");return}
                self.delegate?.retrieveMeteo(answer: meteo)
                
            case .failure(let error):
                self.delegate?.manageError(error: error.localizedDescription)
            }
        }
    }
    
}
