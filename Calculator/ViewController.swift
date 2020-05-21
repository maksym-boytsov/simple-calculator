//
//  ViewController.swift
//  Calculator
//
//  Created by Maksym on 21/05/2020.
//  Copyright © 2020 mayicodefuture. All rights reserved.
//

import UIKit

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    enum Operations {
        case mult
        case div
        case sub
        case add
    }
    
    var memorizedValue: Float? = nil
    var chosenOperation: Operations? = nil
    var calculationPerformed: Bool = false

    func isLabelNull() -> Bool {
        return resultLabel.text == "0" || resultLabel.text == "-0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func unhighlightOperations() {
        divideButton.backgroundColor = UIColor.systemOrange
        multiplyButton.backgroundColor = UIColor.systemOrange
        subtractButton.backgroundColor = UIColor.systemOrange
        addButton.backgroundColor = UIColor.systemOrange
    }
    
    func changeColour(operation: Operations) {
        unhighlightOperations()
        switch operation {
        case .mult:
            multiplyButton.backgroundColor = UIColor.systemYellow
        case .div:
            divideButton.backgroundColor = UIColor.systemYellow
        case .add:
            addButton.backgroundColor = UIColor.systemYellow
        case .sub:
            subtractButton.backgroundColor = UIColor.systemYellow
        }
    }
    
    func performCalculation(operation: Operations) {
        if let string = resultLabel.text, let labelResult = Float(string) {
            if (chosenOperation == Operations.mult) {
                resultLabel.text = String(Float(memorizedValue! * labelResult).clean)
            } else if (chosenOperation == Operations.div) {
                resultLabel.text = String(Float(memorizedValue! / labelResult).clean)
            } else if (chosenOperation == Operations.add) {
                resultLabel.text = String(Float(memorizedValue! + labelResult).clean)
            } else if (chosenOperation == Operations.sub) {
                resultLabel.text = String(Float(memorizedValue! - labelResult).clean)
            }
        }
    }
    
    func pickOperation(operation: Operations) {
        if (memorizedValue != nil) {
            let prevLabel = resultLabel.text
            performCalculation(operation: operation)
            calculationPerformed = true
            memorizedValue = Float(prevLabel!)
        }
        chosenOperation = operation
        changeColour(operation: operation)
    }
    
    func appendDigitToLabel(digit: String) {
        if (chosenOperation == nil) {
            if (isLabelNull()) {
                resultLabel.text = digit
            } else {
                resultLabel.text = resultLabel.text! + digit
            }
            
            if (digit != "0") {
                clearButton.setTitle("C", for: .normal)
            }
        }
        
        if (chosenOperation != nil) {
            if (memorizedValue != nil && !calculationPerformed) {
                if (isLabelNull()) {
                    resultLabel.text = digit
                } else {
                    resultLabel.text = resultLabel.text! + digit
                }
            } else if (memorizedValue == nil || calculationPerformed) {
                unhighlightOperations()
                memorizedValue = Float(resultLabel.text!)
                resultLabel.text = digit
                calculationPerformed = false
            }
        }
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        resultLabel.text = "0"
        memorizedValue = nil
        chosenOperation = nil
        calculationPerformed = false
        clearButton.setTitle("AC", for: .normal)
        unhighlightOperations()
    }
    
    @IBAction func changeSign(_ sender: UIButton) {
        if let string = resultLabel.text, let labelResult = Float(string) {
            resultLabel.text = String(Float(-labelResult).clean)
        }
    }
    
    @IBAction func getResult(_ sender: UIButton) {
        if (memorizedValue != nil && chosenOperation != nil) {
            performCalculation(operation: chosenOperation!)
            calculationPerformed = false
            chosenOperation = nil
            memorizedValue = nil
        }
    }
    
    @IBAction func percentageOfValue(_ sender: UIButton) {
        if (chosenOperation == nil) {
            if let string = resultLabel.text, let labelResult = Float(string) {
                resultLabel.text = String(labelResult * 0.01)
            }
        }
        
        if (memorizedValue != nil && chosenOperation != nil) {
            if let string = resultLabel.text, let labelResult = Float(string) {
                switch chosenOperation {
                case .add:
                    resultLabel.text = String(memorizedValue! + (labelResult / 100))
                case .sub:
                    resultLabel.text = String(memorizedValue! - (labelResult / 100))
                case .mult:
                    resultLabel.text = String(memorizedValue! * (labelResult / 100))
                case .div:
                    resultLabel.text = String(memorizedValue! / (labelResult / 100))
                case .none:
                    print("Error, no operation chosen")
                }
            }
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        let isDotPicked = resultLabel.text?.contains(".")
        if (isDotPicked == false) {
            resultLabel.text = resultLabel.text! + "."
        }
    }
    
    @IBAction func divide(_ sender: UIButton) {
        pickOperation(operation: Operations.div)
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        pickOperation(operation: Operations.mult)
    }
    
    @IBAction func subtract(_ sender: UIButton) {
        pickOperation(operation: Operations.sub)
    }
    
    @IBAction func add(_ sender: UIButton) {
        pickOperation(operation: Operations.add)
    }
    
    @IBAction func zero(_ sender: UIButton) {
        appendDigitToLabel(digit: "0")
    }
    
    @IBAction func one(_ sender: UIButton) {
        appendDigitToLabel(digit: "1")
    }
    
    @IBAction func two(_ sender: UIButton) {
        appendDigitToLabel(digit: "2")
    }
    
    @IBAction func three(_ sender: UIButton) {
        appendDigitToLabel(digit: "3")
    }
    
    @IBAction func four(_ sender: UIButton) {
        appendDigitToLabel(digit: "4")
    }
    
    @IBAction func five(_ sender: UIButton) {
        appendDigitToLabel(digit: "5")
    }
    
    @IBAction func six(_ sender: UIButton) {
        appendDigitToLabel(digit: "6")
    }
    
    @IBAction func seven(_ sender: UIButton) {
        appendDigitToLabel(digit: "7")
    }
    
    @IBAction func eight(_ sender: UIButton) {
        appendDigitToLabel(digit: "8")
    }
    
    @IBAction func nine(_ sender: UIButton) {
        appendDigitToLabel(digit: "9")
    }
}
