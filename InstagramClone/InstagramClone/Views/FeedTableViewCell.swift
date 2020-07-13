//
//  FeedTableViewCell.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/17/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameTitleButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
    }

    private func setupCell() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        selectionStyle = .none
    }
    
}
