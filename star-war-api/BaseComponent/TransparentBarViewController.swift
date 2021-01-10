//
//  TransparentBarViewController.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import UIKit

class TransparentBarViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-arrow")
		self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
		self.navigationItem.backButtonTitle = ""
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
	}
	
	func add(background: UIImage?) {
		let background = UIImageView(image: background)
		background.contentMode = .scaleAspectFill
		self.view.addSubview(background)
		background.snp.makeConstraints { $0.edges.equalToSuperview() }
	}
}
