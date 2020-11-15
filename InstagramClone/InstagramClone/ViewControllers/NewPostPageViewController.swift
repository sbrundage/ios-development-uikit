//
//  NewPostPageViewController.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/3/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class NewPostPageViewController: UIPageViewController {

    var orderedViewControllers: [UIViewController] = [UIViewController]()
    var pagesToShow: [NewPostPagesToShow] = NewPostPagesToShow.pagesToShow()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        setupPagesToShow()
    }
    
    private func setupPagesToShow() {
        
        for pageToShow in pagesToShow {
            let page = newViewController(pageToShow: pageToShow)
            orderedViewControllers.append(page)
        }
        
        guard let firstViewController = orderedViewControllers.first else { return }
        
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        // Setup notification observer to receive notification sent from NewPostViewController with the new page to display
        NotificationCenter.default.addObserver(self, selector: #selector(newPage(notification:)), name: NSNotification.Name("newPage"), object: nil)
    }
    
    // Handle notification sent from NewPostViewController
    @objc func newPage(notification: NSNotification) {
        
        guard let pageToShow = notification.object as? NewPostPagesToShow else { return }
        
        showViewController(index: pageToShow.rawValue)
    }
    
    private func newViewController(pageToShow: NewPostPagesToShow) -> UIViewController {
        
        let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
        var viewController: UIViewController!
        
        switch pageToShow {
        case .camera:
            viewController = newPostStoryboard.instantiateViewController(withIdentifier: pageToShow.identifier) as! CameraViewController
        case .library:
            viewController = newPostStoryboard.instantiateViewController(withIdentifier: pageToShow.identifier) as! PhotoLibraryViewController
        }
        return viewController
    }

    func showViewController(index: Int) {
        
        if currentIndex > index {
            setViewControllers([orderedViewControllers[index]], direction: .reverse, animated: true, completion: nil)
        } else if currentIndex < index {
            setViewControllers([orderedViewControllers[index]], direction: .forward, animated: true, completion: nil)
        }
        
        currentIndex = index
    }
    
    // Deinitialize NotificationCenter observers
    deinit {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("newPage"), object: nil)
    }
}

// MARK: - PageViewController Delegate

extension NewPostPageViewController: UIPageViewControllerDelegate {}

// MARK: - PageViewController Data Source

extension NewPostPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else { return nil }
        guard orderedViewControllersCount > nextIndex else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
}
