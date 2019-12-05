//
//  AFNetwork.swift
//  CryptoPriceTracker
//
//  Created by Stephen Brundage on 9/25/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: String {
    case coinAPI = "https://sandbox-api.coinmarketcap.com"
    case coinAPILatest = "/v1/cryptocurrency/listings/latest"
}

public class AFNetwork {
    internal func getCryptoData() {
        AF.request("https://apiv2.bitcoinaverage.com/metadata", method: .get).responseDecodable(of: BitcoinModel.self) { response in
            print(response)
        }
    }
    
    internal func createHTTPRequest() {
        // Create URL with API endpoint
        if let url = URL(string: Endpoint.coinAPI.rawValue) {
        
            // Create request to send to API
            var request = URLRequest(url: url)
        
            // Add API Key to Headers
            request.allHTTPHeaderFields = [
                "X-CMC_PRO_API_KEY" : API_KEY,
                "Accept" : "application/json",
                "Accept-Encoding" : "deflate, gzip"
            ]
        }
    }
}
