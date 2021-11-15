//
//  ViewController.swift
//  AsyncAwaitNetworking
//
//  Created by Stephen Brundage on 7/7/21.
//

import UIKit

class ViewController: UIViewController {
	
	let tableView: UITableView = {
		let table = UITableView()
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return table
	}()
	
	private var users: [User] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.dataSource = self
		
		Task {
			let result = await fetchUsers()
			
			switch result {
				case .success(let users):
					self.users = users
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				case .failure(let error):
					print("Could not fetch users: \(error)")
			}
		}
	}
	
	private func fetchUsers() async -> Result<[User], Error> {
		
		guard let url = URL(string: Endpoint.users.rawValue) else {
			return .failure(CustomError.invalidURL)
		}
		
		do {
			// URLSession async variant
			let (data, _) = try await URLSession.shared.data(from: url)
			// Parse data response
			let users = try JSONDecoder().decode([User].self, from: data)
			return .success(users)
		} catch {
			return .failure(error)
		}
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = users[indexPath.row].name
		return cell
	}
}
