//
//  CalculatorBrain.swift
//  BMICalculator
//
//  Created by Stephen Brundage on 12/5/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var bmiValue: String?
    
    mutating func calculateBMI(_ height: Float, _ weight: Float) {
        let bmi = (weight / powf(height, 2)) * 703
        
        bmiValue = String(format: "%.1f", bmi)
    }
    
    func getBMIValue() -> String {
        return bmiValue ?? "0.0"
    }
}
