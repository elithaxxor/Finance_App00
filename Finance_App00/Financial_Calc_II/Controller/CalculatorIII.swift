	//
	//  ViewController.swift
	//  CalculatorIII
	//
	//  Created by a-robot on 4/26/22.
	//

import UIKit

@IBDesignable
class CalculatorIII: ViewControllerLogger {
	
	let Logic = operandLogic() // clear, +/- and modulo
	
	private var isFinishedTypingNumber: Bool = true
	@IBOutlet weak var DisplayView: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func logicBtnTap(_ sender: UIButton) {
		
		isFinishedTypingNumber = true
		
			// [convert to double, check if nill'
		guard let number = Double(DisplayView.text!) else {
			fatalError("Cannot Convert Display values. ")
		}
		print(number)
		
			// [Operand Buttons]
		if let calcMethod = sender.currentTitle {
			if calcMethod == "+/-" {
                let reversedNum = Logic.reverseNum(reverse: number)
                print("[MOD-NUM] \(reversedNum) Called")
				DisplayView.text = String(reversedNum)
			}
			
			if calcMethod == "AC" {
                let clearStr = String(number)
                let clearedView = Logic.clearView(clear: clearStr)
                print("[MOD-NUM] \(clearStr) Called")
				DisplayView.text = clearedView
			}
			if calcMethod == "%" {
                let modNum = Logic.modNum(mod: number)
                print("[MOD-NUM] \(modNum) Called")

			}
			
			if calcMethod == "." {
				guard let decVal = Double(DisplayView.text!) else { fatalError("Could not validate num for \(DisplayView.text)")}
                let decimalNum = Logic.handleDecimal(num: decVal)
                print("[BEING CALCUALTED] \(decimalNum)")
			}
			if calcMethod == "+" {
                let calcStr = String(number)
                print("[OPERAND] \(calcStr) Called")
                let results = Logic.calculate(value: calcStr, operand: "+")
                print("[+] [RESULTS] \(results)")

			}
			if calcMethod == "-" {
                let calcStr = String(number)
                print("[OPERAND] \(calcStr) Called")
                let results = Logic.calculate(value: calcStr, operand: "-")
                print("[+] [RESULTS] \(results)")

			}
			if calcMethod == "*" {
                let calcStr = String(number)
                print("[OPERAND] \(calcStr) Called")
                let results = Logic.calculate(value: calcStr, operand:  "*")
                print("[+] [RESULTS] \(results)")

			}
			if calcMethod == "/" {
                let calcStr = String(number)
                print("[OPERAND] \(calcStr) Called")
				let results = Logic.calculate(value: calcStr, operand: "/")
                print("[+] [RESULTS] \(results)")

			}
			
			
			
			
			
				//var displayNum = Double(DisplayView.text)
			if let displayNum = Double(DisplayView.text!) {
                print("Could Display Number, exiting function \(String(describing: DisplayView.text))")
                let strDisplay = String(displayNum)
				DisplayView.text = strDisplay
			}
			
			else {
                print("Could Display Number, exiting function \(String(describing: DisplayView.text))")
                let strDisplay = String(number)
				DisplayView.text = strDisplay
			}
			
            print(DisplayView.text ?? "FIX-ME [Calc DisplayView]")
		}
		
		
	}
	
	
	@IBAction func numBtnTap(_ sender: UIButton) {
		print("User Tapped \(sender)")
		if let val = sender.currentTitle {
			if isFinishedTypingNumber == true {
				DisplayView.text = val
				isFinishedTypingNumber = false
			}
			else { // appends additional digits to display
				DisplayView.text = DisplayView.text! + val
			}
		}
	}
}



