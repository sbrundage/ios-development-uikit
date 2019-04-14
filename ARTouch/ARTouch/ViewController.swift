//
//  ViewController.swift
//  ARTouch
//
//  Created by Stephen on 4/14/19.
//  Copyright © 2019 Brundage. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

enum BoxBodyType : Int {
    case bullet = 1
    case barrier = 2
}

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        let box1 = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.blue
        box1.materials = [material]
        
        let box1Node = SCNNode(geometry: box1)
        let box2Node = SCNNode(geometry: box1)
        let box3Node = SCNNode(geometry: box1)
        
        //Add physics body to boxes
        box1Node.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        box2Node.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        box3Node.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        //Add bitmask value
        box1Node.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        box2Node.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        box3Node.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        
        box1Node.position = SCNVector3(0, 0, -0.4)
        box2Node.position = SCNVector3(-0.2, 0, -0.4)
        box3Node.position = SCNVector3(0.2, 0.2, -0.5)
        
        scene.rootNode.addChildNode(box1Node)
        scene.rootNode.addChildNode(box2Node)
        scene.rootNode.addChildNode(box3Node)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        registerGestureRecognizer()
    }
    
    private func registerGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shoot))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func shoot(recognizer: UITapGestureRecognizer) {
        
        //get current AR frame
        guard let currentFrame = self.sceneView.session.currentFrame else { return }
        var translation = matrix_identity_float4x4
        
        translation.columns.3.z = -0.3
        
        let sphere = SCNSphere(radius: 0.05)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.yellow
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        sphereNode.physicsBody?.isAffectedByGravity = false
        sphereNode.physicsBody?.categoryBitMask = BoxBodyType.bullet.rawValue
        sphereNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        
        let forceVector = SCNVector3(sphereNode.worldFront.x * 2, sphereNode.worldFront.y * 2, sphereNode.worldFront.z * 2)
        sphereNode.physicsBody?.applyForce(forceVector, asImpulse: true)
        self.sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
