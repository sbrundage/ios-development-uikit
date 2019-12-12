//
//  CoinData.swift
//  BitcoinTracker
//
//  Created by Stephen Brundage on 12/11/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case price = "last"
    }
}
