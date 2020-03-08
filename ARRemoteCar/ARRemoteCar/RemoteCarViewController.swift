//
//  ViewController.swift
//  ARRemoteCar
//
//  Created by Stephen Brundage on 3/4/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class RemoteCarViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Scene View, give a frame
        sceneView = ARSCNView(frame: self.view.frame)
        
        // Add Scene View to View
        self.view.addSubview(sceneView)
        
        // Configure Scene View options
        // Default lighting, feature points, & world origin
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        
        // Set Sceneview Delegate
        sceneView.delegate = self
        
        // Create car scene
        let carScene = SCNScene(named: "car.dae")!
        
        // Create car node
        let carNode = carScene.rootNode.childNode(withName: "car", recursively: true)!
        carNode.position = SCNVector3(0, -0.5, -0.5)
        
        // Add car node to scene
        sceneView.scene.rootNode.addChildNode(carNode)
        sceneView.scene = carScene
    }
    
    private func setupControlPad() {
        let leftButton = UIButton(frame: CGRect(x: 0, y: self.sceneView.frame.height - 40, width: 50, height: 50))
        leftButton.setTitle("Left", for: .normal)
        self.sceneView.addSubview(leftButton)
        
        let rightButton = UIButton(frame: CGRect(x: 50, y: self.sceneView.frame.height - 40, width: 50, height: 50))
        rightButton.setTitle("Right", for: .normal)
        self.sceneView.addSubview(rightButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Create ARWorldTrackingConfiguration to retrieve information back from the ARScene
        let configuration = ARWorldTrackingConfiguration()
        
        // Add horizontal and vertical plane detection
        configuration.planeDetection = [.vertical, .horizontal]
        
        // Run AR Configuration
        sceneView.session.run(configuration)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Pause AR Session when view disappears
        sceneView.session.pause()
    }
}
