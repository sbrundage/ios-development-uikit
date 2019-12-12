//
//  ViewController.swift
//
//  BitcoinViewController.swift
//  BitcoinTracker
//
//  Created by Stephen Brundage on 12/11/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController, UIPickerViewDataSource {
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

extension BitcoinViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DispatchQueue.main.async {
            let currency = self.coinManager.currencyArray[row]
            
            self.coinManager.getCoinPrice(for: currency)
        }
    }
}

extension BitcoinViewController: CoinManagerDelegate {
    func didUpdatePrice(_ price: String, _ currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
