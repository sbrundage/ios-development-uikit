//
//  ViewController.swift
//  ARPokemon
//
//  Created by Stephen on 3/20/19.
//  Copyright © 2019 Brundage. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Magazines", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
            print("Images Successfully Added")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let imagePlane = SCNPlane(
                width: imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height)
            
            imagePlane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.2)
            
            let planeNode = SCNNode(geometry: imagePlane)
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            
            if let pokeScene = SCNScene(named: "art.scnassets/gangar.scn") {
                
                //Create out 3D object node that we will augment
                let pokeNode = pokeScene.rootNode.childNodes.first
                pokeNode?.scale = SCNVector3(0.01, 0.01, 0.01)
                
                //Add materials to 3D object
                let material1 = SCNMaterial()
                material1.diffuse.contents = UIImage(named: "art.scnassets/gangar_0_0.tga")
                
                let material2 = SCNMaterial()
                material2.diffuse.contents = UIImage(named: "art.scnassets/gangar_0_1.tga")

//                let material3 = SCNMaterial()
//                material3.diffuse.contents = UIImage(named: "art.scnassets/GangarEyeDh.tga")
                
                pokeNode?.geometry?.materials = [material1, material2]
                
                pokeNode?.eulerAngles.x = .pi
                
                planeNode.addChildNode(pokeNode!)
            }
        }
        
        return node
    }

}
