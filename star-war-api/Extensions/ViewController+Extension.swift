//
//  ViewController+Extension.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import UIKit

extension UIViewController {
	func addNavigationBar() {
		let customBar = NavigationBarView()
		self.view.addSubview(customBar)
		customBar.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
		}
	}
}
