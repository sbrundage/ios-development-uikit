//
//  ViewController.swift
//  ARKitCoreLocation
//
//  Created by Stephen Brundage on 3/8/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import ARCL

class ARViewController: UIViewController {
    
    var destination: String!
    
    lazy private var locationManager = CLLocationManager()
    var sceneLocationView = SceneLocationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = destination
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        setupLocationManager()
        findLocalPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        sceneLocationView.pause()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func findLocalPlaces() {
        // Get current location of user
        guard let location = locationManager.location else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = destination
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            // To Do: Handle Error
            // For now, we will just return
            if error != nil { return }
            
            // Make sure response is not nil
            guard let response = response else { return }
            
            for item in response.mapItems {
                if let placeLocation = item.placemark.location {
                    self.createAnnotationNode(for: placeLocation, name: item.placemark.name!)
                }
            }
        }
    }
    
    private func createAnnotationNode(for location: CLLocation, name: String) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let location = CLLocation(coordinate: coordinate, altitude: 200)
        
        let placeAnnotation = PlaceAnnotation(location: location, title: name)
        placeAnnotation.scaleRelativeToDistance = false
        
//        let pin = UIImage(named: "pin")!
//        let annotationNode = LocationAnnotationNode(location: location, image: pin)
//        annotationNode.scaleRelativeToDistance = false
        
        DispatchQueue.main.async {
            self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: placeAnnotation)
        }
    }
}

// MARK: - CL Location Manager Delegate extension
extension ARViewController: CLLocationManagerDelegate {
    
}
