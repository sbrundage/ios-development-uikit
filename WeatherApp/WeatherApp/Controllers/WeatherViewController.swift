//
//  ViewController.swift
//  WeatherApp
//
//  Created by Stephen Brundage on 12/7/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    // IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Save entered text
        if let city = textField.text {
            weatherManager.fetchCityName(cityName: city)
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

