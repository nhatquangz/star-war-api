//
//  DetailViewController.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import UIKit

class DetailViewController: TransparentBarViewController {
	
	let viewModel: DetailViewModel
	
	init(viewModel: DetailViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
	
}

// MARK: - Setup UI
extension DetailViewController {
	func setup() {
		let resourceType = viewModel.resourceType
		self.add(background: resourceType.background)
		let titleView = TitleView(title: viewModel.item.title, color: resourceType.color)
		self.navigationItem.titleView = titleView
	}
}

