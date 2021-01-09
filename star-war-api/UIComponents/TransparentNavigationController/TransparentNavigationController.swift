//
//  TransparentNavigationController.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import UIKit

class TransparentNavigationController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationBar.backIndicatorImage = UIImage(named: "back-arrow")
		self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
		
		self.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationBar.shadowImage = UIImage()
		self.navigationBar.isTranslucent = true
		
	}
}
