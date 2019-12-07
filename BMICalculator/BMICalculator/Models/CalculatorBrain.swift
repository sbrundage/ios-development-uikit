//
//  CalculatorBrain.swift
//  BMICalculator
//
//  Created by Stephen Brundage on 12/5/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    mutating func calculateBMI(_ height: Float, _ weight: Float) {
        let bmiValue = (weight / powf(height, 2)) * 703
        
        var advice: String
        var color: UIColor
        
        if bmiValue < 18.5 {
            // Underweight
            advice = "You Are Underweight"
            color = .green
        } else if bmiValue < 24.9 {
            // Normal
            advice = "Your BMI Is Normal"
            color = .yellow
        } else {
            // Overweight
            // Greater than 24.9
            advice = "You might want to bring that BMI down"
            color = .red
        }
        
        bmi = BMI(value: bmiValue, advice: advice, color: color)
    }
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No Advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
}
