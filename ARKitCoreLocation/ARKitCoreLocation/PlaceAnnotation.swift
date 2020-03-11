//
//  PlaceAnnotation.swift
//  ARKitCoreLocation
//
//  Created by Stephen Brundage on 3/11/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation
import ARCL
import CoreLocation
import SceneKit

class PlaceAnnotation: LocationNode {
    
    var title: String
    var annotationNode: SCNNode
    
    init(location: CLLocation?, title: String) {
        self.annotationNode = SCNNode()
        self.title = title
        
        super.init(location: location)
        
        initializeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        let plane = SCNPlane(width: 5, height: 3)
        plane.cornerRadius = 0.2
        plane.firstMaterial?.diffuse.contents = UIColor.blue
        
        let text = SCNText(string: title, extrusionDepth: 0)
        text.containerFrame = CGRect(x: 0, y: 0, width: 5, height: 3)
        text.isWrapped = true
        text.font = UIFont(name: "Futura", size: 1.0)
        text.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        text.truncationMode = CATextLayerTruncationMode.middle.rawValue
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0, 0, 0.2)
        center(node: textNode)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.addChildNode(textNode)
        
        // Had to mess around with scale in order to get a reasonable size for the labels
        annotationNode.scale = SCNVector3(20, 20, 20)
        annotationNode.addChildNode(planeNode)
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
        
        self.addChildNode(annotationNode)
    }
    
    private func center(node: SCNNode) {
        let (min, max) = node.boundingBox
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        node.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
    }
}
