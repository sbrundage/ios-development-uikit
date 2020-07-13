//
//  StoriesTableViewCell.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/17/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    lazy var stories: [Story] = {
        let model = Model()
        
        // Return mock data
        return model.storyList
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Setup
    private func setupCell() {
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryCollectionViewCell")
        storiesCollectionView.showsHorizontalScrollIndicator = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        storiesCollectionView.collectionViewLayout = flowLayout
        
        selectionStyle = .none
    }
}

// MARK: - UICollectionViewDelegate
extension StoriesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 110)
    }
}

// MARK: - UICollectionViewDataSource
extension StoriesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
        
        cell.storyImage.image = stories[indexPath.row].post.postImage
        cell.userNameLabel.text = stories[indexPath.row].post.user.name
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StoriesTableViewCell: UICollectionViewDelegateFlowLayout { }
