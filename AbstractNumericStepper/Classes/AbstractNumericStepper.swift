//
//  AbstractNumericStepper.swift
//  Pods
//
//  Created by Paolo Iulita on 03/05/16.
//
//

import Foundation
import UIKit

public protocol AbstractNumericStepperDelegate: NSObjectProtocol {
	func numericStepper(numericStepper: AbstractNumericStepper, valueChanged value: Double)
}

public class AbstractNumericStepper: UIView, UITextFieldDelegate {
	
	// MARK: initializers
	
	public override func awakeFromNib() {
		textField.delegate = self
	}
		
	// MARK: outlets
	
	@IBOutlet weak var increment: UIButton!
	@IBOutlet weak var decrement: UIButton!
	@IBOutlet weak var textField: UITextField!
	
	// MARK: actions
	
	@IBAction func onIncrement(sender: UIButton) {
		value += step
	}
	
	@IBAction func onDecrement(sender: UIButton) {
		value -= step
	}
	
	// MARK: properties
	
	public var delegate: AbstractNumericStepperDelegate?
	public var value: Double = 0 {
		didSet {
			if !canShowDecimalValues {
				value = round(value)
			}
			value = Swift.min(value, max)
			value = Swift.max(value, min)
			decrement.enabled = value >= min
			increment.enabled = value <= max
			updateTextField()
			if value != oldValue {
				delegate?.numericStepper(self, valueChanged: value)	
			}
		}
	}
	public var min: Double = 0 {
		didSet {
			value = Swift.max(value, min)
		}
	}
	public var max: Double = 10 {
		didSet {
			value = Swift.min(value, max)
		}
	}
	public var step: Double = 1
	public var canShowDecimalValues: Bool = false
	public var currencySymbol: String = ""
	
	// MARK: methods
	
	// MARK: private properties
	
	private func updateTextField() {
		var valueToString = ""
		if !canShowDecimalValues {
			valueToString = "\(Int(value))"
		} else {
			valueToString = String(value)
		}
		textField.text = "\(valueToString) \(currencySymbol)"
	}
	
	// MARK: private methods
	
	// MARK: UITextFieldDelegate
	
	public func textFieldDidEndEditing(textField: UITextField) {
		print(textField.text)
	}
	
	public func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}
