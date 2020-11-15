//
//  SceneDelegate.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/13/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	let tabBarDelegate = TabBarDelegate()
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		self.window = UIWindow(windowScene: windowScene)
		
		let tabController = UITabBarController()
		
		let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
		let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
		let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
		let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
		let activityStoryboard = UIStoryboard(name: "Activity", bundle: nil)
		
		let homeVC = homeStoryboard.instantiateViewController(identifier: "Home") as! HomeViewController
		let searchVC = searchStoryboard.instantiateViewController(identifier: "Search") as! SearchViewController
		let newPostVC = newPostStoryboard.instantiateViewController(identifier: "NewPost") as! NewPostViewController
		let profileVC = profileStoryboard.instantiateViewController(identifier: "Profile") as! ProfileViewController
		let activityVC = activityStoryboard.instantiateViewController(identifier: "Activity") as! ActivityViewController
		
		let vcData: [(UIViewController, UIImage, UIImage)] = [
			(homeVC, UIImage(named: "home_tab_icon")!, UIImage(named: "home_selected_tab_icon")!),
			(searchVC, UIImage(named: "search_tab_icon")!, UIImage(named: "search_selected_tab_icon")!),
			(newPostVC, UIImage(named: "post_tab_icon")!, UIImage(named: "post_tab_icon")!),
			(activityVC, UIImage(named: "activity_tab_icon")!, UIImage(named: "activity_selected_tab_icon")!),
			(profileVC, UIImage(named: "profile_tab_icon")!, UIImage(named: "profile_selected_tab_icon")!)
			
		]
		
		let controllers = vcData.map { (vc, defaultImage, selectedImage) -> UINavigationController in
			let navController = UINavigationController(rootViewController: vc)
			
			navController.tabBarItem.image = defaultImage
			navController.tabBarItem.selectedImage = selectedImage
			
			return navController
		}
		
		tabController.viewControllers = controllers
		tabController.tabBar.isTranslucent = false
		
		tabController.delegate = tabBarDelegate
		
		if let items = tabController.tabBar.items {
			for item in items {
				if let image = item.image {
					item.image = image.withRenderingMode(.alwaysOriginal)
				}
				
				if let selectedImage = item.selectedImage {
					item.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
				}
				
				item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
			}
		}
		
		UINavigationBar.appearance().backgroundColor = .white
		self.window?.rootViewController = tabController
		self.window?.makeKeyAndVisible()
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
	
	
}

