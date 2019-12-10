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
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            task.resume()
        } else { print("Could not perform request") }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let weatherModel = try decoder.decode(WeatherData.self, from: weatherData)
            let id = weatherModel.weather[0].id
            let temp = weatherModel.main.temp
            let name = weatherModel.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.temperatureString)
        } catch {
            print(error)
        }
    }
}
