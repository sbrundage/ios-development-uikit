//
//  ViewController.swift
//  Calculator
//
//  Created by Stephen Brundage on 1/5/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    private var calculator = CalculatorLogic()
    
    private var isFinishedTypingNumber: Bool = true
    private var displayValue: Double {
        get {
                guard let number = Double(displayLabel.text!) else { fatalError("Cannot convert display label text to a Double") }
                return number
        }
        set {
            if calculator.isInt(newValue) {
                displayLabel.text = String(Int(newValue))
            } else {
                displayLabel.text = String(newValue)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcValue = sender.currentTitle {
            if let result = calculator.calcValue(calcValue) {
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                
                if numValue == "." {
                    
                    if !calculator.isInt(displayValue) {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }


}

