//
//  ResultViewController.swift
//  BMICalculator
//
//  Created by Stephen Brundage on 12/5/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmiValue
        adviceLabel.text = advice
        view.backgroundColor = color
    }
    
    @IBAction func recalculateClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
