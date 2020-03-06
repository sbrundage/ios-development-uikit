//
//  NetworkManager.swift
//  FlowerScanner
//
//  Created by Stephen Brundage on 2/15/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {

    let baseURL = "https://en.wikipedia.org/w/api.php"
    
    func requestFlowerDetails(flowerName: String, completion: @escaping (String?) -> Void) {
                
        let parameters: [String : String] = [
            "format": "json",
            "action": "query",
            "prop": "extracts",
            "exintro": "",
            "explaintext": "",
            "titles": flowerName,
            "indexpageids": "",
            "redirects": "1",
        ]
        
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let jsonData):
                if let json = JSON(jsonData)["query"]["pages"].first {
                    if let extractResponse = json.1.dictionary?["extract"] {
                        if let extractString = extractResponse.string {
                            completion(extractString)
                        }
                    }
                }
            case .failure(let error):
                print("There was an error in request: \(error)")
                completion(nil)
            }
        }
    }
}
