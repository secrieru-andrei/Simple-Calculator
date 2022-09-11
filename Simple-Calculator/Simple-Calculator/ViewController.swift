//
//  ViewController.swift
//  Simple-Calculator
//
//  Created by Secrieru Andrei on 08.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var currentOperation: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var calculatorButtons: [UIButton]!
    var numberOnScreen: Double = 0
    var firstNumber: Double = 0
    var operation: Int = 0
    public var operationArray = [OperationHistory]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentOperation.text = ""
        resultLabel.text = ""
        navigationItem.title = "CALCULATOR"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(pushHistoryView(sender:)))
        view.backgroundColor = UIColor(named: "backgroundColor")
        
    }
    
    @objc func pushHistoryView(sender: Any){
        let newView = HistoryViewController()
        navigationController?.pushViewController(newView, animated: true)
        newView.array = operationArray
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
    
            resultLabel.text! += String(sender.tag)
            if let number = resultLabel.text {
                numberOnScreen = Double(number)!
                currentOperation.text! += String(sender.tag)
            }
    }
    
    @IBAction func operationButtons(_ sender: UIButton) {
        if sender.tag != 10 {
            if let selectedOperation = sender.titleLabel?.text {
                currentOperation.text! += selectedOperation
            }
        }
        if sender.tag != 10 && sender.tag != 11 && sender.tag != 17 && sender.tag != 18 && sender.tag != 12 {
            
            firstNumber = numberOnScreen
            resultLabel.text = ""
            operation = sender.tag
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
            eraseButton.isEnabled = false
           
        } else if sender.tag == 10 {
                numberOnScreen = 0
                firstNumber = 0
                resultLabel.text = ""
            if let text = currentOperation.text {
                if !text.isEmpty {
                let newItem = OperationHistory(operation: text)
                operationArray.append(newItem)
                }
            }
            currentOperation.text = ""
            eraseButton.isEnabled = true
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
    
    @IBAction func erase(_ sender: Any) {
        if let text = resultLabel.text {
            if !text.isEmpty{
                resultLabel.text?.removeLast()
                currentOperation.text?.removeLast()
                if let number = resultLabel.text {
                    if let number2 = Double(number){
                        numberOnScreen = number2
                    }
                  }
            }
        }
    }
}


