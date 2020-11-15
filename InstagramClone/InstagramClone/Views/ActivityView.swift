//
//  ActivityView.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/15/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class ActivityView: UIView {
	
	static let identifier = "ActivityView"
	
	@IBOutlet weak var tableView: UITableView!
	
	var activityData: [Activity] = [Activity]() {
		didSet {
			
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(UINib(nibName: ActivityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ActivityTableViewCell.identifier)
		tableView.tableFooterView = UIView()
	}
	
}

extension ActivityView: UITableViewDelegate {}

extension ActivityView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return activityData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier) as! ActivityTableViewCell
		
		cell.profileImage.image = activityData[indexPath.row].userImage
		cell.detailsLabel.text = activityData[indexPath.row].details
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
}
