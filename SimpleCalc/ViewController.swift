//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Mohamed El Naggar on 4/7/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userBeginTyping: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        sender.layer.cornerRadius = 0.5
        let digit = sender.currentTitle!
        if userBeginTyping {
            display.text = digit
        } else {
            display.text = display.text! + digit
        }
        
        userBeginTyping = false
    }
    
    var brainCalc = calculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userBeginTyping == false {
            brainCalc.setOperand(operand: displayValue)
            userBeginTyping = true
        }
        if let mathSymbol = sender.currentTitle {
            brainCalc.performOperation(symbol: mathSymbol)
        }
        displayValue = brainCalc.result
    }
}

