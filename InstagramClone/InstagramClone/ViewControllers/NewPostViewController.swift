//
//  NewPostViewController.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/13/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

// Helps determine which ViewController to display from NewPost.storyboard
enum NewPostPagesToShow: Int {
    case library, camera
    
    var identifier: String {
        switch self {
        case .library:
            return "PhotoLibraryViewController"
        case .camera:
            return "CameraViewController"
        }
    }
    
    static func pagesToShow() -> [NewPostPagesToShow] {
        return [.library, .camera]
    }
}

class NewPostViewController: UIViewController {

    override var prefersStatusBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func libraryButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("newPage"), object: NewPostPagesToShow.library)
    }
    
    @IBAction func photoButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("newPage"), object: NewPostPagesToShow.camera)
    }
}
