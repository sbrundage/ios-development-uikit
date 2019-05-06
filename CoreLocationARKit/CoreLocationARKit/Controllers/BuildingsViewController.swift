//
//  PlacesTableViewController.swift
//  CoreLocationARKit
//
//  Created by Stephen on 3/31/19.
//  Copyright © 2019 Brundage. All rights reserved.
//

import Foundation
import UIKit

class BuildingsViewController : UITableViewController {
    
    private let destinations = ["UCF", "Coffee", "Bars", "Fast Food", "Banks", "Hospitals", "Gas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.destinations[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = (self.tableView.indexPathForSelectedRow)!
        let place = self.destinations[indexPath.row]
        
        let vc = segue.destination as! ViewController
        vc.place = place
    }
}
