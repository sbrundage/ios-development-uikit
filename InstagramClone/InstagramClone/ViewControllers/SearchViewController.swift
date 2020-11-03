//
//  SearchViewController.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/13/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    private var searchController: UISearchController!
    
    lazy var posts: [Post] = {
        let model = Model()
        return model.postList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchViewController()
    }
    
    private func setupSearchViewController() {
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self

        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.showsCancelButton = false
        
        // Iterate over subviews to get a reference to the textField within the searchController
        for subView in searchController.searchBar.subviews {
            for uiView in subView.subviews {
                if let textField = uiView as? UITextField {
                    textField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
                    textField.textAlignment = .center
                }
            }
        }
        
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchController.searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarContainer
    }

}

extension SearchViewController: UICollectionViewDelegate {}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        
        cell.exploreImage.image = posts[indexPath.row].postImage
        
        return cell
    }
    
}
