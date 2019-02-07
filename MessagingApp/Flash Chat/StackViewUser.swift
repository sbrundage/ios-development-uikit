//
//  StackViewUser.swift
//  Flash Chat
//
//  Created by Stephen on 2/4/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StackViewUser : UIView
{
    @IBOutlet weak var userName : UILabel!
    
    func initializeFromXIB()
    {
        let nib = UINib(nibName: "StackViewUser", bundle: Bundle.main)
        
        guard let rootView = nib.instantiate(withOwner: self).first as? UIView
        else { return }
        
        rootView.frame = self.bounds
        
        self.addSubview(rootView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeFromXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeFromXIB()
        
    }
    
}
