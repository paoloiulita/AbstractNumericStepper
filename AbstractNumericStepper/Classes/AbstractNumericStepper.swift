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
}

class AbstractNumericStepper: UIView {
	
	// MARK: initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupUI()
	}
	
	// MARK: outlets
	
	@IBOutlet weak var increment: UIButton!
	@IBOutlet weak var decrement: UIButton!
	@IBOutlet weak var background: UIView!
	@IBOutlet weak var text: UITextField!
	@IBOutlet weak var suffix: UILabel!
	
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
			//value = min(value, max)
			//decrement.enabled = value >= min
			//increment.enabled = value <= max
		}
	}
	var min: Double = 0
	var max: Double = 10
	var step: Double = 1
	var canShowDecimalValues: Bool = false
	var canDirectInputValues: Bool = false
	var defaultBorderColor = UIColor.darkGrayColor()
	var invalidBorderColor = UIColor.redColor()
	var validBorderColor = UIColor.greenColor()
	
	// MARK: private properties
	
	// MARK: methods
	
	// MARK: private methods
	
	private func setupUI() {
		// background.layer.borderColor = UIColor(rgba: defaultBorderColor).CGColor
		background.layer.borderWidth = 1
	}
}
