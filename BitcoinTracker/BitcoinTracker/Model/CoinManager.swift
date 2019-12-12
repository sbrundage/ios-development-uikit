//
//  CoinManager.swift
//  BitcoinTracker
//
//  Created by Stephen Brundage on 12/11/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ price: String, _ currency: String)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let requestURL = baseURL + currency
        
        if let url = URL(string: requestURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let bitcoinModel = self.parseJSON(safeData) {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        let formattedPrice = formatter.string(from: NSNumber(value: bitcoinModel.price))
                        self.delegate?.didUpdatePrice(formattedPrice!, currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let coin = try decoder.decode(CoinData.self, from: data)
            return coin
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
