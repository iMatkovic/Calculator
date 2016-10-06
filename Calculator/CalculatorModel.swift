//
//  CalculatorModel.swift
//  Calculator
//
//  Created by COBE on 05/10/16.
//  Copyright © 2016 COBE. All rights reserved.
//

import Foundation



class CalculatorModel{
    
    private var accumulator = 0.0
    
    func setOpreand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOpreation({$0 * $1}),
        "÷" : Operation.BinaryOpreation({$0 / $1}),
        "+" : Operation.BinaryOpreation({$0 + $1}),
        "-" : Operation.BinaryOpreation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOpreation((Double,Double) -> Double)
        case Equals
    }
    
    
    func preformOperation(symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOpreation(let function):
                executePendingBinaryOpreatin()
                pending = PendngBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOpreatin()
            }
        }
    }
    
    
    
    private func executePendingBinaryOpreatin(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendngBinaryOperationInfo?
    
    private struct PendngBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    
    
    
}
