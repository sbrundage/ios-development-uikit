//
//  TabBarDelegate.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/3/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation
import UIKit

class TabBarDelegate: NSObject, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let navigationController = viewController as? UINavigationController
        navigationController?.popViewController(animated: false)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let selectedVC = tabBarController.selectedViewController else { return false }
        
        if viewController == selectedVC { return false }
        
        guard let controllerIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else { return true }
        
        if controllerIndex == 2 {
            let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
            let newPostVC = newPostStoryboard.instantiateViewController(identifier: "NewPost") as! NewPostViewController
            let navController = UINavigationController(rootViewController: newPostVC)
            
            selectedVC.present(navController, animated: true, completion: nil)
            return false
        }
        
        let navigationController = viewController as? UINavigationController
        navigationController?.popViewController(animated: false)
        
        return true
    }
}
