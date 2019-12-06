//
//  ViewController.swift
//  BMICalculator
//
//  Created by Stephen Brundage on 12/5/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var bmiValue = "0.0"
    
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
    
    @IBAction func calculatePressed(_ sender: Any) {
        let weight = weightSlider.value
        let height = heightSlider.value
        
        let bmi = calculateBMI(height, weight)
        bmiValue = String(format: "%.1f", bmi)
        
        // Show new ViewController
        self.performSegue(withIdentifier: "presentResultsViewController", sender: self)
    }
    
    private func calculateBMI(_ height: Float, _ weight: Float) -> Float {
        return (weight / powf(height, 2)) * 703
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentResultsViewController" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = bmiValue
        }
    }
}

