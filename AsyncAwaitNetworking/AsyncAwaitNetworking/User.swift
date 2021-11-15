//
//  User.swift
//  AsyncAwaitNetworking
//
//  Created by Stephen Brundage on 7/7/21.
//

import Foundation

struct User: Codable {
	let id: Int
	let name: String
	let username: String
	let email: String
	let address: Address
	let phone: String
}

struct Address: Codable {
	let street: String
	let city: String
	let zipcode: String
}
