//
//  OverlayPlane.swift
//  ARModels
//
//  Created by Stephen Brundage on 9/17/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation
import ARKit

class OverlayPlane: SCNNode {
    
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(anchor: ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
    }
    
    private func setup() {
        self.planeGeometry = SCNPlane(width: CGFloat(self.anchor.extent.x), height: CGFloat(self.anchor.extent.z))
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue.withAlphaComponent(0.5)
        
        self.planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0, 0)
        
        // Add to parent
        self.addChildNode(planeNode)
    }
}
