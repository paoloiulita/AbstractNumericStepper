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
		textField.keyboardType = .DecimalPad
		let numberToolbar: UIToolbar = UIToolbar()
		numberToolbar.barStyle = .Default
		numberToolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Done", style: .Bordered, target: self, action: #selector(onDone))
		]
		numberToolbar.sizeToFit()
		textField.inputAccessoryView = numberToolbar
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
	public var canShowDecimalValues: Bool = false {
		didSet {
			updateTextField()
		}
	}
	public var currencySymbol: String = "" {
		didSet {
			if currencySymbol != "" {
				updateTextField()
			}
		}
	}
	public var shouldRoundToHalfDecimal: Bool = false
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
	
	public func textFieldDidEndEditing(textField: UITextField) {
		updateValue()
	}
	
	public func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}
