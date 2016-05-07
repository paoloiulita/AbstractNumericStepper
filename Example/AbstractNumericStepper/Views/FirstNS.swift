//
//  FirstNS.swift
//  AbstractNumericStepper
//
//  Created by Paolo Iulita on 04/05/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import AbstractNumericStepper

class FirstNS: AbstractNumericStepper {

	// MARK: initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		loadViewFromNib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadViewFromNib()
	}
	
	// MARK: private methods
	
	private func loadViewFromNib() {
		let bundle = NSBundle(forClass: self.dynamicType)
		let nib = UINib(nibName: "FirstNS", bundle: bundle)
		let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
		view.frame = bounds
		view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
		self.addSubview(view);
	}
	
}