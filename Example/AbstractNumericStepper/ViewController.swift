//
//  ViewController.swift
//  AbstractNumericStepper
//
//  Created by Paolo Iulita on 05/07/2016.
//  Copyright (c) 2016 Paolo Iulita. All rights reserved.
//

import UIKit
import AbstractNumericStepper

class ViewController: UIViewController, AbstractNumericStepperDelegate {

	@IBOutlet weak var firstNS: AbstractNumericStepper!
	@IBOutlet weak var secondNS: AbstractNumericStepper!

	@IBOutlet weak var firstLabel: UILabel!
	@IBOutlet weak var secondLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        firstNS.delegate = self
		firstNS.min = 2
		firstNS.max = 7
		firstNS.canShowDecimalValues = true
		firstNS.shouldRoundToHalfDecimal = true
		firstNS.step = 0.3
		firstNS.tag = 1
		
		secondNS.delegate = self
		secondNS.min = 100
		secondNS.max = 1000
		secondNS.step = 50
		secondNS.currencySymbol = "€"
		secondNS.tag = 2
		secondNS.canShowDecimalValues = false
		secondNS.canDirectInputValues = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: AbstractNumericStepperDelegate
	
	func numericStepper(numericStepper: AbstractNumericStepper, valueChanged value: Double) {
		if numericStepper.tag == 1 {
			firstLabel.text = "\(numericStepper.value)"
		} else if numericStepper.tag == 2 {
			secondLabel.text = "\(numericStepper.value)"
		}
	}
	
}

