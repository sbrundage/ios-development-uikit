//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Stephen Brundage on 12/9/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: TempInfo
    let weather: [WeatherInfo]
}

struct TempInfo: Decodable {
    let temp: Double
}

struct WeatherInfo: Decodable {
    let main: String
    let id: Int
}
