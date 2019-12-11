//
//  ViewController.swift
//  WeatherApp
//
//  Created by Stephen Brundage on 12/7/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        // Request permission to user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    @IBAction func currentWeatherPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Save entered text
        if let city = textField.text {
            weatherManager.fetchWeather(city)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something..."
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            locationManager.stopUpdatingLocation()
            
            let currentLat = currentLocation.coordinate.latitude
            let currentLon = currentLocation.coordinate.longitude
            
            weatherManager.fetchWeather(currentLat, currentLon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
