//
//  CalculatorBrain.swift
//  SimpleCalc
//
//  Created by Mohamed El Naggar on 4/7/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import Foundation


class calculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String , operationEnum> = [
        "π" : operationEnum.Constant(Double.pi) , // PI
        "e" : operationEnum.Constant(M_E) , // e
        "√" : operationEnum.UnaryOperation(sqrt) , //sqrt
        "cos" : operationEnum.UnaryOperation(cos) , // cos
        "x" : operationEnum.BinaryOperation({$0 * $1}),
        "+" : operationEnum.BinaryOperation({$0 + $1}),
        "÷" : operationEnum.BinaryOperation({$0 / $1}),
        "−" : operationEnum.BinaryOperation({$0 - $1}),
        "=" : operationEnum.Equals
    ]
    
    private enum operationEnum {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double , Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let val): accumulator = val
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals : executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand , accumulator)
            pending = nil
        }
    }
    
    private var pending: pendingBinaryOperationInfo?
    
    private struct pendingBinaryOperationInfo {
        var binaryFunction: (Double , Double) -> Double
        var firstOperand: Double
    }
    
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
