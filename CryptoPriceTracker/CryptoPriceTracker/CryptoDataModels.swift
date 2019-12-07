//
//  CryptoDataModels.swift
//  CryptoPriceTracker
//
//  Created by Stephen Brundage on 9/25/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation

public struct BitcoinModel: Codable {
    var BTC: String
    var info: CoinInfo
}



public struct EtheriumModel: Codable {
    
}

public protocol CoinProtocol {
    var coin: String { get }
    var info: CoinInfo { get }
}

public struct CoinInfo: Codable {
    var marketCap: Float
    var circulatingSuppy: Float
    var volume: Float
    
    enum CodingKeys: String, CodingKey {
        case marketCap = "market_cap"
        case circulatingSuppy = "circulating_supply"
        case volume = "volume"
    }
}
