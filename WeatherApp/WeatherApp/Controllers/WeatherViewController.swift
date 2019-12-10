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
    
    func didUpdateWeather(weather: WeatherModel) {
//        temperatureLabel.text = weather.temperatureString
//        cityLabel.text = weather.cityName
//        conditionImageView.image = UIImage(named: weather.conditionName)
    }
}

