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
	/**
	Invoked on each update of value
	
	- Parameters:
	- numericStepper: The actual component which is changing
	- valueChanged: the new value
	*/
	func numericStepper(numericStepper: AbstractNumericStepper, valueChanged value: Double)
}

/// Contains methods for easily creating a numeric stepper
public class AbstractNumericStepper: UIView, UITextFieldDelegate {
	
	// MARK: initializers
	
	public override func awakeFromNib() {
		textField.delegate = self
		textField.keyboardType = .DecimalPad
		let numberToolbar: UIToolbar = UIToolbar()
		numberToolbar.barStyle = .Default
		numberToolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(onDone))
		]
		numberToolbar.sizeToFit()
		textField.inputAccessoryView = numberToolbar
	}
	
	// MARK: outlets
	
	@IBOutlet weak var increment: UIButton!
	@IBOutlet weak var decrement: UIButton!
	@IBOutlet weak var textField: UITextField!
	
	// MARK: actions
	
	/**
		change the model by adding a defined step value
		
		- Parameter sender: The UIButton invoking
	*/
	@IBAction func onIncrement(sender: UIButton) {
		value += step
	}
	
	/**
		change the model by subtracting a defined step value
	
		- Parameter sender: The UIButton invoking
	*/
	@IBAction func onDecrement(sender: UIButton) {
		value -= step
	}
	
	// MARK: properties
	
	/// The object implementing the method called when value changes
	public var delegate: AbstractNumericStepperDelegate?
	
	/// The actual value of the numeric stepper
	public var value: Double = 0 {
		didSet {
			let isInt = floor(value) == value
			if !canShowDecimalValues {
				value = round(value)
			} else if shouldRoundToHalfDecimal && !isInt {
				var fValue: Double = floor(value)
				if (value - fValue) > 0.5 {
					fValue += 1
				} else {
					fValue += 0.5
				}
				value = fValue
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
	
	/// The minimum value allowed to be set
	public var min: Double = 0 {
		didSet {
			value = Swift.max(value, min)
		}
	}
	
	/// The maximum value allowed to be set
	public var max: Double = 10 {
		didSet {
			value = Swift.min(value, max)
		}
	}
	
	/// The quantity to be added or subtracted on each button press
	public var step: Double = 1
	
	/// Defines if the numeric stepper should or not show only integers
	public var canShowDecimalValues: Bool = false {
		didSet {
			updateTextField()
		}
	}
	
	/// The symbol that can be placed after the value
	public var currencySymbol: String = "" {
		didSet {
			if currencySymbol != "" {
				updateTextField()
			}
		}
	}
	
	/// Defines if the value should be rounded at the neares half decimal (0.5) point
	public var shouldRoundToHalfDecimal: Bool = false
	
	/// Defines if the UITextField shoul be interactive
	public var canDirectInputValues: Bool = true {
		didSet {
			if canDirectInputValues {
				textField.delegate = self
			} else {
				textField.delegate = nil
			}
			textField.userInteractionEnabled = canDirectInputValues
		}
	}
	
	// MARK: private methods
	
	private func updateTextField() {
		var valueToString = ""
		if !canShowDecimalValues {
			valueToString = "\(Int(value))"
		} else {
			valueToString = String(value)
		}
		if currencySymbol != "" {
			textField.text = "\(valueToString) \(currencySymbol)"
		} else {
			textField.text = valueToString
		}
	}
	
	private func updateValue() {
		if let tValue = textField.text {
			value = Double(tValue) ?? min
		}
	}
	
	@objc private func onDone() {
		textField.resignFirstResponder()
	}
	
	// MARK: UITextFieldDelegate
	
	private func textFieldDidEndEditing(textField: UITextField) {
		updateValue()
	}
	
	private func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}
