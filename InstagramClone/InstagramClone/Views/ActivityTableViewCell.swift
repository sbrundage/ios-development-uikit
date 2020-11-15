//
//  ActivityTableViewCell.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/15/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var detailsLabel: UILabel!
	
	static let identifier = "ActivityTableViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()

		profileImage.layer.masksToBounds = true
		
		selectionStyle = .none
		
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		
		profileImage.layer.cornerRadius = profileImage.frame.width / 2
	}
    
}
