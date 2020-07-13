//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/13/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    lazy var posts: [Post] = {
        let model = Model()
        
        // Return mock data
        return model.postList
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    // MARK: - Setup
    private func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "StoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "StoriesTableViewCell")
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove default TableView lines
        tableView.tableFooterView = UIView()
        
        tableView.showsVerticalScrollIndicator = false
        
        var rightBarItemImage = UIImage(named: "send_nav_icon")
        rightBarItemImage = rightBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarItemImage, style: .plain, target: nil, action: nil)
        
        var leftBarItemImage = UIImage(named: "send_nav_icon")
        leftBarItemImage = leftBarItemImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarItemImage, style: .plain, target: nil, action: nil)
        
        let profileImageView = UIImageView(image: UIImage(named: "logo_nav_icon"))
        self.navigationItem.titleView = profileImageView
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            // Display StoriesTableViewCell at the first index (index 0)
            let storiesCell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell") as! StoriesTableViewCell
            
            return storiesCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        
        let currentIndex = indexPath.row - 1
        let postData = posts[currentIndex]
        
        cell.profileImage.image = postData.user.profileImage
        cell.postImage.image = postData.postImage
        cell.dateLabel.text = postData.datePosted
        cell.likesCountLabel.text = "\(postData.likesCount) likes"
        cell.postCommentLabel.text = postData.postComment
        cell.userNameTitleButton.setTitle(postData.user.name, for: .normal)
        cell.commentCountButton.setTitle("View all \(postData.commentCount) comments", for: .normal)
        
        return cell
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Compensate for the first cell being StoriesTableViewCell
        return posts.count + 1
    }
}
