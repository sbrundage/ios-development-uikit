//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Stephen Brundage on 12/8/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial"
    
    init() {
        weatherURL = weatherURL + "&appid=\(API_KEY)"
    }
    
    func fetchCityName(cityName: String) {
        let urlString = weatherURL + "&q=\(cityName)"
        print(urlString)
    }
}
