//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/3/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: SimpleCameraView!
    
    var simpleCamera: SimpleCamera!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        simpleCamera = SimpleCamera(cameraView: cameraView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        simpleCamera.startSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        simpleCamera.stopSession()
    }
    
    @IBAction func startCapture(_ sender: Any) {
        // Only handle image capture, not videos
        guard simpleCamera.currentCaptureMode == .photo else { return }

        simpleCamera.takePhoto { (imageData, success) in
            guard success else { return }
            
            print("Image successfully captured")
        }
    }
    
}
