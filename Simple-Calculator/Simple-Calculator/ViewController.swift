//
//  ViewController.swift
//  Simple-Calculator
//
//  Created by Secrieru Andrei on 08.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentOperation: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var calculatorButtons: [UIButton]!
    var numberOnScreen: Double = 0
    var firstNumber: Double = 0
    var operation: Int = 0
    var flag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentOperation.text = ""
        resultLabel.text = ""
        navigationItem.title = "CALCULATOR"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .bookmarks)
        view.backgroundColor = UIColor(named: "backgroundColor")
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
    
            resultLabel.text! += String(sender.tag)
            if let number = resultLabel.text {
                numberOnScreen = Double(number)!
                currentOperation.text! += String(sender.tag)
            }
    }
    
    @IBAction func operationButtons(_ sender: UIButton) {
        if let selectedOperation = sender.titleLabel?.text {
            currentOperation.text! += selectedOperation
        }
        if sender.tag != 10 && sender.tag != 11 && sender.tag != 17 && sender.tag != 18 && sender.tag != 12 {
            
            firstNumber = numberOnScreen
            resultLabel.text = ""
            operation = sender.tag
            flag = true
        } else if sender.tag == 17 {
            var result = 0.0
        
            if operation == 13 {
                result = firstNumber / numberOnScreen
            }
            if operation == 14 {
                result = firstNumber * numberOnScreen
            }
            if operation == 15 {
                result = firstNumber - numberOnScreen
            }
            if operation == 16 {
                result = firstNumber + numberOnScreen
            }
            
            numberOnScreen = result
            firstNumber = 0
            let formatedResult = resultFormat(sender: String(result))
            currentOperation.text! += " " + formatedResult
            resultLabel.text = formatedResult
           
        } else if sender.tag == 10 {
                numberOnScreen = 0
                firstNumber = 0
                resultLabel.text = ""
                currentOperation.text = ""
        } else if sender.tag == 11 {
            if let negatedNumber = resultLabel.text {
                if var number = Double(negatedNumber){
                    number.negate()
                    numberOnScreen = number
                    resultLabel.text = resultFormat(sender: String(number))
                }
            }
        } else if sender.tag == 18 {
            if var numberWithPoint = resultLabel.text{
                numberWithPoint += "."
                resultLabel.text = numberWithPoint
            }
        } else if sender.tag == 12 {
            
                resultLabel.text = String((firstNumber * numberOnScreen) / 100)
            print(firstNumber)
            print(numberOnScreen)
            print("fuck")
        }
    }
    
    func resultFormat (sender: String) -> String {
        var number = sender
        if number.last == "0" {
            number.removeLast()
        }
        if  number.last == "." {
            number.removeLast()
        }
        return number
    }
}


