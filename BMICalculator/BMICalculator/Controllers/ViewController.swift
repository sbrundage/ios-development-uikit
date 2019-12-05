//
//  ViewController.swift
//  BMICalculator
//
//  Created by Stephen Brundage on 12/5/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Height slider value changed
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String.init(format: "%.2f", sender.value)
        
        heightLabel.text = height + " ft"
    }
    
    // Weight slide value changed
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = Int(sender.value)
        
        weightLabel.text = "\(weight) lbs"
    }
    
}

