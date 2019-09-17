//
//  UCFNavViewController.swift
//  CoreLocationARKit
//
//  Created by Stephen on 3/31/19.
//  Copyright © 2019 Brundage. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import MapKit
import SceneKit

class UCFNavViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationNodeArray: [LocationAnnotationNode]!
    var sceneLocationView = SceneLocationView()
    lazy private var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        self.view.addSubview(sceneLocationView)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        setupLocationNodes()
        
        addLocationNodesToAR()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = self.view.bounds
    }

    private func setupLocationNodes() {
        let image = UIImage(named: "map-pin")
        let plane = SCNPlane(width: 5, height: 3)
        plane.cornerRadius = 0.2
        plane.firstMaterial?.diffuse.contents = UIColor.blue
        let planeNode = SCNNode(geometry: plane)
        //continue to add plane above node instead of giant png
        
//        let engILocation = CLLocation(latitude: 28.6014342, longitude: -81.2009329)
//        let engILocNode = LocationAnnotationNode(location: engILocation, image: image!)
//        engILocNode.tag = "Engineering I"
//        engILocNode.scale = SCNVector3(50,50,50)
//        engILocNode.scaleRelativeToDistance = true
        
        let cbIILocation = CLLocation(latitude: 28.6043058, longitude: -81.2001114)
        let cbIILocNode = LocationAnnotationNode(location: cbIILocation, image: image!)
        cbIILocNode.tag = "Classroom Building II"
        cbIILocNode.scale = SCNVector3(50,50,50)
        cbIILocNode.scaleRelativeToDistance = true
        
//        let psychLocation = CLLocation(latitude: 28.6046554, longitude: -81.1995065)
//        let psychLocNode = LocationAnnotationNode(location: psychLocation, image: image!)
//        cbIILocNode.tag = "Psychology"
//        cbIILocNode.scale = SCNVector3(50,50,50)
//        cbIILocNode.scaleRelativeToDistance = true
        
        locationNodeArray = [cbIILocNode]
    }
    
    private func addLocationNodesToAR() {
        for locationNode in locationNodeArray {
            print(locationNode.tag!)
            DispatchQueue.main.async {
                self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: locationNode)
            }
        }
    }

}
