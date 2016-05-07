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

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNS.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: AbstractNumericStepperDelegate
	
	func numericStepper(numericStepper: AbstractNumericStepper, valueChanged value: Double) {
		print(value)
	}
	
	func numericStepper(numericStepper: AbstractNumericStepper, changedValidationStatus valid: Bool) {
		
	}

}

