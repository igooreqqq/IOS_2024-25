//
//  ViewController.swift
//  calculator
//
//  Created by user252224 on 11/19/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorResult: UILabel!
    @IBOutlet weak var calculatorScreen: UILabel!
    
    var workings: String = ""
    var isResultDisplayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    func clearAll() {
        workings = ""
        calculatorResult.text = "0"
        calculatorScreen.text = ""
        isResultDisplayed = false
    }
    

    func addToWorkings(value: String) {
        if isResultDisplayed {
            if value.range(of: "[0-9.]", options: .regularExpression) != nil {
                workings = ""
                calculatorResult.text = ""
                calculatorScreen.text = ""
            }
            isResultDisplayed = false
        }
        
        workings += value
        calculatorScreen.text = workings
    }
    
    @IBAction func allClearButton(_ sender: Any) {
        clearAll()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        if !workings.isEmpty {
            workings.removeLast()
            calculatorScreen.text = workings
            if workings.isEmpty {
                calculatorResult.text = "0"
            }
        }
    }
    
    @IBAction func percentButton(_ sender: Any) {
        addToWorkings(value: "%")
    }
    
    @IBAction func divideButton(_ sender: Any) {
        addToWorkings(value: "/")
    }
    
    @IBAction func multiplyButton(_ sender: Any) {
        addToWorkings(value: "*")
    }
    
    @IBAction func substractButton(_ sender: Any) {
        addToWorkings(value: "-")
    }
    
    @IBAction func addButton(_ sender: Any) {
        addToWorkings(value: "+")
    }
    
    @IBAction func powButton(_ sender: Any) {
        addToWorkings(value: "^")
    }
    
    @IBAction func logButton(_ sender: Any) {
        addToWorkings(value: "log")
    }
    
    @IBAction func equalsButton(_ sender: Any) {
        if !workings.isEmpty {
                if let result = calculateResult(from: workings) {
                    let finalResult = isNegative ? -result : result

                    calculatorResult.text = String(finalResult)
                    workings = String(finalResult)
                    isResultDisplayed = true
                    isNegative = false
                } else {
                    calculatorResult.text = "Error"
                    isResultDisplayed = true
                    isNegative = false
                }
            }
    }
    
    @IBAction func dotButton(_ sender: Any) {
        let components = workings.components(separatedBy: CharacterSet(charactersIn: "+-*/%^"))
        if let last = components.last, !last.contains(".") {
            addToWorkings(value: ".")
        }
    }
    
    var isNegative: Bool = false
    
    @IBAction func negativeButton(_ sender: Any) {
        isNegative.toggle()
        if !workings.isEmpty {
                if let result = calculateResult(from: workings) {

                    let finalResult = isNegative ? -result : result
                    
                    calculatorResult.text = String(finalResult)
                    workings = String(finalResult)
                    isResultDisplayed = true
                    isNegative = false
                } else {
                    calculatorResult.text = "Error"
                    isResultDisplayed = true
                    isNegative = false
                }
            }
    }
    
    @IBAction func zeroButton(_ sender: Any) {
        addToWorkings(value: "0")
    }
    
    @IBAction func oneButton(_ sender: Any) {
        addToWorkings(value: "1")
    }
    
    @IBAction func twoButton(_ sender: Any) {
        addToWorkings(value: "2")
    }
    
    @IBAction func threeButton(_ sender: Any) {
        addToWorkings(value: "3")
    }
    
    @IBAction func fourButton(_ sender: Any) {
        addToWorkings(value: "4")
    }
    
    @IBAction func fiveButton(_ sender: Any) {
        addToWorkings(value: "5")
    }
    
    @IBAction func sixButton(_ sender: Any) {
        addToWorkings(value: "6")
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        addToWorkings(value: "7")
    }
    
    @IBAction func eightButton(_ sender: Any) {
        addToWorkings(value: "8")
    }
    
    @IBAction func nineButton(_ sender: Any) {
        addToWorkings(value: "9")
    }
    
    func calculateResult(from expression: String) -> Double? {
        var expression = expression.trimmingCharacters(in: .whitespaces)
        var tokens: [String] = []
        var currentNumber = ""
        var i = expression.startIndex
        
        while i < expression.endIndex {
            let char = expression[i]
            
            if char.isNumber || char == "." {
                currentNumber.append(char)
                i = expression.index(after: i)
            } else if char == "-" {
                if !currentNumber.isEmpty {
                    tokens.append(currentNumber)
                    currentNumber = ""
                }
                
                if tokens.isEmpty || ["+", "-", "*", "/", "^", "%"].contains(tokens.last ?? "") {
                    currentNumber.append(char)
                } else {
                    tokens.append(String(char))
                }
                i = expression.index(after: i)
            } else if ["+", "*", "/", "^", "%"].contains(String(char)) {
                if !currentNumber.isEmpty {
                    tokens.append(currentNumber)
                    currentNumber = ""
                }
                tokens.append(String(char))
                i = expression.index(after: i)
            } else {
                i = expression.index(after: i)
            }
        }
        
        if !currentNumber.isEmpty {
            tokens.append(currentNumber)
        }

        var stack: [Double] = []
        var operators: [String] = []
        
        var index = 0
        while index < tokens.count {
            let token = tokens[index]
            
            if let number = Double(token) {
                stack.append(number)
            } else if token == "^" {
                if let base = stack.popLast() {
                    stack.append(pow(base, 2))
                } else {
                    return nil
                }
            } else if token == "%" {
                if let last = stack.popLast() {
                    stack.append(last * 0.01)
                } else {
                    return nil
                }
            } else if ["+", "-", "*", "/"].contains(token) {
                operators.append(token)
            } else {
                return nil
            }
            index += 1
        }
    
        guard stack.count >= 1 else { return nil }
        var result = stack[0]
        var numberIndex = 1
        
        for op in operators {
            if numberIndex >= stack.count {
                return nil
            }
            let nextNumber = stack[numberIndex]
            numberIndex += 1
            
            switch op {
            case "+":
                result += nextNumber
            case "-":
                result -= nextNumber
            case "*":
                result *= nextNumber
            case "/":
                if nextNumber == 0 {
                    return nil
                }
                result /= nextNumber
            default:
                return nil
            }
        }
        
        return result
    }
}
