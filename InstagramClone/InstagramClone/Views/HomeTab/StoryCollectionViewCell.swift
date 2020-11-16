//
//  StoryCollectionViewCell.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/17/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
    }

    private func setupCell() {
        storyImage.layer.cornerRadius = storyImage.frame.width / 2
        storyImage.layer.masksToBounds = true
        storyImage.layer.borderColor = UIColor.white.cgColor
        storyImage.layer.borderWidth = CGFloat(3.0)
    }
}
