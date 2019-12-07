//
//  ViewController.swift
//  CryptoPriceTracker
//
//  Created by Stephen Brundage on 9/25/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var currencyPicker: UIPickerView?
    var currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIPicker()
        
        let network = AFNetwork()
        network.getBitcoinAverageMetadata()
    }
    
    private func setupUIPicker() {
        currencyPicker?.delegate = self
        currencyPicker?.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
}

