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
    @IBOutlet weak var clickHistory: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    var numbersToBeCalculted = Array<String>()
    var clickedHistoryInMemory = Array<String>()
    
    @IBAction func clearMemory(sender: UIButton) {
        numbersToBeCalculted = Array<String>()
        clickedHistoryInMemory = Array<String>()
        display.text = "0"
        clickHistory.text = ""
    }
    
    @IBAction func clickButton(sender: UIButton) {
        
        if display.text! == "∏" {
            appendTheDisplay()
            userIsInTheMiddleOfTyping = false
        }

        let clickedButton = sender.currentTitle!
        
        if display.text!.rangeOfString(".") != nil && clickedButton == "." { return }
        
        if userIsInTheMiddleOfTyping {
            if clickedButton == "∏" {
                appendTheDisplay ()
                display.text = "∏"
            } else {
                display.text = display.text! + clickedButton
            }
            
        } else {
            display.text = clickedButton
            userIsInTheMiddleOfTyping = true            
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        var operatorClicked = sender.currentTitle!

        appendTheDisplay ()
        updateClickHistory(operatorClicked)
        
        switch operatorClicked {
//        case "↵" : numbersToBeCalculted.append(display.text!)
            case "+" : calculate({ $1 + $0 })
            case "−" : calculate({ $1 - $0 })
            case "×" : calculate({ $1 * $0 })
            case "÷" : calculate({ $1 / $0 })
            case "√" : calculate({ sqrt($0) })
            case "sin" : calculate({ sin($0) })
            case "cos" : calculate({ cos($0) })
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
        }
    }
    
    func calculate(singularCal: (num1:Double) -> Double) {
        if numbersToBeCalculted.count >= 1 {
            let number1 = NSNumberFormatter().numberFromString(numbersToBeCalculted.removeLast())!.doubleValue
            var result = singularCal(num1: number1)
            
            display.text = "\(result)";
        }
    }
    
    func appendTheDisplay () {
        if display.text! == "∏" {
            numbersToBeCalculted.append("\(M_PI)")
        } else {
            numbersToBeCalculted.append(display.text!)
        }

        updateClickHistory(display.text!)
    }
    
    func updateClickHistory (saveForMemory: String) {
        clickedHistoryInMemory.append(saveForMemory)
        clickHistory.text = clickedHistoryInMemory.description
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

