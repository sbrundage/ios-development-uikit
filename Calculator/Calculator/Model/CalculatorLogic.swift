//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Stephen Brundage on 1/5/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    private var intermediateCalculations: (numbers: [Double], calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calcValue(_ calculationString: String) -> Double? {
        if let n = number {
            switch calculationString {
            case "AC":
                return 0
            case "+/-":
                return n * -1
            case "%":
                return n / 100
            case "=":
                return performTwoNumberCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: calculationString)
            }
        }
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                // Protect against dividing by 0
                if n2 == 0 { return nil } else { return n1 / n2 }
            default:
                fatalError("Could not find operation")
            }
        } else { return nil }
    }
    
//    private func performMultipleNumberCalculations(numbers: [Double]) -> Double? {
//        
//    }
    
    func isInt(_ value: Double) -> Bool {
        let isInt = floor(value) == value
        
        if !isInt { return false } else { return true }
    }
}
