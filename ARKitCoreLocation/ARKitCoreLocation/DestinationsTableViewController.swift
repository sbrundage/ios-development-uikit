//
//  DestinationsViewController.swift
//  ARKitCoreLocation
//
//  Created by Stephen Brundage on 3/8/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class DestinationsTableViewController: UITableViewController {
    
    private var destinations = ["Coffee Shops", "Food", "Gas Stations", "Hospitals", "Bars", "Gyms"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinations.sort()
    }
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = destinations[indexPath.row]
        return cell
    }
    
    // MARK: - Segue to ARViewController
    // Get the selected destination, pass to the ARViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let destination = destinations[indexPath.row]
            if let destinationVC = segue.destination as? ARViewController {
                destinationVC.destination = destination
            } else { fatalError("Could not cast as ARViewController") }
        }
    }
}
