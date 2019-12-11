//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Stephen Brundage on 12/8/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation
import CoreLocation

// Weather Manager Delegate Protocol
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

// Handles weather data
struct WeatherManager {
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    init() {
        weatherURL = weatherURL + "&appid=\(API_KEY)"
    }
    
    func fetchWeather(_ cityName: String) {
        let urlString = weatherURL + "&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let urlString = weatherURL + "&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    } else {
                        print("There was issue with parseJSON")
                    }
                }
            }
            
            task.resume()
        } else { print("Could not perform request") }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let weatherModel = try decoder.decode(WeatherData.self, from: weatherData)
            let id = weatherModel.weather[0].id
            let temp = weatherModel.main.temp
            let name = weatherModel.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
