//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Huan Wang on 4/8/15.
//  Copyright (c) 2015 Huan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    var numbersToBeCalculted = Array<String>()
    
    @IBAction func clickButton(sender: UIButton) {
        let clickedButton = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + clickedButton
        } else {
            display.text = clickedButton
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        var operatorClicked = sender.currentTitle!

        numbersToBeCalculted.append(display.text!)
        
        switch operatorClicked {
//        case "↵" : numbersToBeCalculted.append(display.text!)
        case "+" : calculate({ $1 + $0 })
        case "−" : calculate({ $1 - $0 })
        case "×" : calculate({ $1 * $0 })
        case "÷" : calculate({ $1 / $0 })
        case "√" : calculate({ sqrt($0) })
        default : break
        }

        userIsInTheMiddleOfTyping = false
        
        println("numbersToBeCalculted is: \(numbersToBeCalculted)")
    }
    
    func calculate(binaryCal: (num1:Double, num2:Double) -> Double){
        if numbersToBeCalculted.count >= 2 {
            let number1 = NSNumberFormatter().numberFromString(numbersToBeCalculted.removeLast())!.doubleValue
            let number2 = NSNumberFormatter().numberFromString(numbersToBeCalculted.removeLast())!.doubleValue
            var result = binaryCal(num1: number1, num2: number2)
            
            display.text = "\(result)";
            numbersToBeCalculted.append("\(result)")
        }
    }
    
    func calculate(singularCal: (num1:Double) -> Double) {
        if numbersToBeCalculted.count >= 1 {
            let number1 = NSNumberFormatter().numberFromString(numbersToBeCalculted.removeLast())!.doubleValue
            var result = singularCal(num1: number1)
            
            display.text = "\(result)";
            numbersToBeCalculted.append("\(result)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

