//
//  ViewController.swift
//  Calculator
//
//  Created by COBE on 05/10/16.
//  Copyright © 2016 COBE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton){
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            
        }else{
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var cm = CalculatorModel()
    
    @IBAction private func preformOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            cm.setOpreand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            cm.preformOperation(symbol: mathematicalSymbol)
        }
        displayValue = cm.result
        
    }
}
