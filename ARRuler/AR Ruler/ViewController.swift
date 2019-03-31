//
//  ViewController.swift
//  AR Ruler
//
//  Created by Stephen on 3/18/19.
//  Copyright © 2019 Brundage. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var dotNodeArray = [SCNNode]()
    var textGeo: SCNText?
    var textNode: SCNNode?
    var lineNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Reset touches if there are more than 2
        if dotNodeArray.count >= 2 {
            removeDots()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResults.first {
                addDot(at: hitResult)
            }
        }
    }
    
    @IBAction func resetPoints(_ sender: UIBarButtonItem) {
        removeDots()
    }
    
    func removeDots() {
        for dotNode in dotNodeArray {
            dotNode.removeFromParentNode()
            dotNodeArray = [SCNNode]()
        }
        textNode?.removeFromParentNode()
    }
    
    func addDot(at hitResult : ARHitTestResult) {
        let dotGeometry = SCNSphere(radius: 0.0025)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.position = SCNVector3(
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y,
            hitResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
        dotNodeArray.append(dotNode)
        
        if dotNodeArray.count >= 2 {
            calculate()
            connectDots()
        }
    }
    
    func calculate() {
        let start = dotNodeArray[0]
        let end = dotNodeArray[1]
        
        //Pythagorean Theorem - Define vars
        let a = end.position.x - start.position.x
        let b = end.position.y - start.position.y
        let c = end.position.z - start.position.z
        
        let distance = abs(sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2)))
        
        updateText(text: "\(distance)", atPosition: end.position)
    }
    
    func connectDots() {
//        let lineGeometry = SCNGeometry.line(from: dotNodeArray[0].position, to: dotNodeArray[1].position)
//        lineNode = SCNNode(geometry: lineGeometry)
//        lineNode?.position = SCNVector3Zero
        
        sceneView.scene.rootNode.addChildNode((lineNode?.buildLineInTwoPointsWithRotation(
            from: dotNodeArray[0].position, to: dotNodeArray[1].position, radius: 0.0025, color: .blue))!)        
    }
    
    func updateText(text: String, atPosition position: SCNVector3) {
        
        textGeo = SCNText(string: text, extrusionDepth: 1.0)
        
        textGeo?.firstMaterial?.diffuse.contents = UIColor.blue
        
        textNode = SCNNode(geometry: textGeo)
        textNode?.position = SCNVector3(position.x, position.y + 0.01, position.z)
        textNode?.scale = SCNVector3(0.005, 0.005, 0.005)
        
        sceneView.scene.rootNode.addChildNode(textNode!)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
}

extension SCNGeometry {
    class func line(from vector1: SCNVector3, to vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
}
