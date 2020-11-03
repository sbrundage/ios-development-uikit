//
//  SearchBarContainerView.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/17/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class SearchBarContainerView: UIView {

    let searchBar: UISearchBar
    
    init(customSearchBar: UISearchBar) {
        self.searchBar = customSearchBar
        
        super.init(frame: .zero)
        
        addSubview(searchBar)
    }
    
    convenience override init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchBar.frame = bounds
    }
}
