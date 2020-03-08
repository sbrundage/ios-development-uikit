//
//  ViewController.swift
//  ARKitCoreLocation
//
//  Created by Stephen Brundage on 3/8/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit
import CoreLocation

class ARViewController: UIViewController {
    
    var destination: String!
    
    lazy private var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = destination
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CL Location Manager Delegate extension
extension ARViewController: CLLocationManagerDelegate {
    
}
