//
//  DestinationsViewController.swift
//  ARKitCoreLocation
//
//  Created by Stephen Brundage on 3/8/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class DestinationsTableViewController: UITableViewController {
    
    private let destinations = ["Coffee Shops", "Food", "Gas Stations", "Hospitals", "Bars"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = destinations[indexPath.row]
        return cell
    }
}
