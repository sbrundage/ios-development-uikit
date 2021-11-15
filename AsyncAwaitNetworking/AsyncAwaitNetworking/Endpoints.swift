//
//  Endpoints.swift
//  AsyncAwaitNetworking
//
//  Created by Stephen Brundage on 7/7/21.
//

import Foundation

enum Endpoint: String {
	case users = "https://jsonplaceholder.typicode.com/users"
}

enum CustomError: Error {
	case invalidURL
	case networkError(Error)
	case decodingError
}


