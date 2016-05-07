//
//  AbstractNumericStepper.swift
//  Pods
//
//  Created by Paolo Iulita on 03/05/16.
//
//

import Foundation
import UIKit

protocol AbstractNumericStepperDelegate: NSObjectProtocol {
	func numericStepper(numericStepper: AbstractNumericStepper, valueChanged value: Double)
	func numericStepper(numericStepper: AbstractNumericStepper, changedValidationStatus valid: Bool)
}

public class AbstractNumericStepper: UIView {
	
	// MARK: initializers
		
	// MARK: outlets
	
	@IBOutlet weak var increment: UIButton!
	@IBOutlet weak var decrement: UIButton!
	@IBOutlet weak var background: UIView!
	@IBOutlet weak var text: UITextField!
	
	// MARK: actions
	
	@IBAction func onIncrement(sender: UIButton) {
		value += step
	}
	
	@IBAction func onDecrement(sender: UIButton) {
		value -= step
	}
	
	// MARK: properties
	
	var delegate: AbstractNumericStepperDelegate?
	var value: Double = 0 {
		didSet {
			if !canShowDecimalValues {
				value = round(value)
			}
			value = Swift.min(value, max)
			value = Swift.max(value, min)
			decrement.enabled = value >= min
			increment.enabled = value <= max
			updateTextField()
		}
	}
	var min: Double = 0
	var max: Double = 10
	var step: Double = 1
	var canShowDecimalValues: Bool = false
	var currencySymbol: String = ""
	
	// MARK: methods
	
	// MARK: private properties
	
	private func updateTextField() {
		var stringedValue = ""
		if !canShowDecimalValues {
			stringedValue = "\(Int(value))"
		} else {
			stringedValue = String(value)
		}
		text.text = "\(stringedValue) \(currencySymbol)"
	}
	
	// MARK: private methods
	
}
