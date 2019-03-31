//
//  ViewController.swift
//  CoreLocationARKit
//
//  Created by Stephen on 3/31/19.
//  Copyright © 2019 Brundage. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import ARCL

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var place: String!
    
    var sceneLocationView = SceneLocationView()
    
    lazy private var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        self.view.addSubview(sceneLocationView)
        
        self.title = self.place
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        findLocalPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = self.view.bounds
    }


    private func findLocalPlaces() {
        
        //Get location of user
        guard let location = self.locationManager.location else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        request.region = region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if error != nil { return }
            
            guard let response = response else { return }
            
            for item in response.mapItems {
                
                let placeLocation = item.placemark.location
                let image = UIImage(named: "map-pin")!
                let annotationNode = LocationAnnotationNode(location: placeLocation, image: image)
                
                annotationNode.scaleRelativeToDistance = true
                DispatchQueue.main.async {
                    self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
                }
            }
        }
    }
}

