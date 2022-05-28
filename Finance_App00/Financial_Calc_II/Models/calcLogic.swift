	//
	//  calcLogic.swift
	//  CalculatorIII (iOS)
	//
	//  Created by a-robot on 4/26/22.
	//

import Foundation

class operandLogic {
	
	private var doubVal = Double?.self
	private var intermediateCalc: (n1: Double, operand: String)?// tuple for calculations

//	mutating func setNum (_ doubVal: Double){ // setter
//		self.doubVal = doubVal
//	}

		// [for calculations that requre more than one step. ] --> save vals in tuple (or dict, may change later)
	func calculate(value: String, operand: String) -> Double {
		
		 func performOperation(n4: Double) -> Double { //[MAY NEED TO PULL OUT, AND SET AS MUTATING METHOD]
			if let val = intermediateCalc?.n1, // input value
			   let op = intermediateCalc?.operand {
				if op == "+"{
					print("[*] Operation performed \(val * val)")
					
					return val + val
				}
				else if op == "-" {
					print("[-] Operation performed \(val - val)")
					
					return val - val
				}
				else if op == "*" {
					print("[*] Operation performed \(val * val)")
					
					return val * val
				}
				else if op == "/" {
					print("[/] Operation performed \(val / val)")
					return val / val
				}
			}
			print("[-] Error in calculating tuple vals \(n4)")

			return n4
		}
		
		print("from calculate logic \(value)")
		var doubVal = Double(value)
		
		if let n = doubVal {
			if operand == "+" {
				intermediateCalc = (n1: n, operand: "+")
			}
			if operand == "-" {
				intermediateCalc = (n1: n, operand: "-")
			}
			if operand == "*" {
				intermediateCalc = (n1: n, operand: "*")
				
			}
			if operand == "=" {
				var calculatedResults = performOperation(n4: n) // calls calculator operator logic, uses tuple intermediateCalc to parse values entered.
				print("calculatedResults \(calculatedResults)")
			} else { // edge case, if no operand is entered:
				print("[?]--> Processing edgecase for no operand entered--> MAY BE A BUG HERE.")
				intermediateCalc = (n1: n, operand: operand)
				var calculatedResults = performOperation(n4: n)
				print("calculatedResults \(calculatedResults)")
			}
			
		}
		print("[-] Error in parsing operand and val to tuple \(doubVal)")
		return doubVal!
	}
	
	
		// operand
	func reverseNum(reverse: Double) -> Double { //  [+/ btn ]
		print("reversing \(reverse)")
		return reverse * 1
	}
	
	func clearView(clear: String) -> String { // [clear btn]
		return ""
	}
	
	func modNum(mod: Double) -> Double { // [modulus btn]
		return mod / 100
	}
	
	public func handleDecimal(num: Double) -> Double {
		var handledD = floor(num)
		return handledD
	}
	
}



