//
//  ListViewController.swift
//  star-war-api
//
//  Created by nhatquangz on 07/01/2021.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
	
	let tableView = UITableView()
	let customBar = NavigationBarView()
	
	let resource: StarWarsResources
	
	init(resource: StarWarsResources) {
		self.resource = resource
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

// MARK: - Setup
extension ListViewController {
	func setup() {
		self.navigationController?.isNavigationBarHidden = false
		self.navigationController?.navigationBar.tintColor = resource.color
		
		/// Background
		let background = UIImageView(image: resource.background)
		background.contentMode = .scaleAspectFill
		self.view.addSubview(background)
		background.snp.makeConstraints { $0.edges.equalToSuperview() }
		
		/// Tableview
		self.view.addSubview(tableView)
		tableView.backgroundColor = .clear
		tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
		tableView.snp.makeConstraints {
			$0.leading.trailing.bottom.equalToSuperview()
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
		}
		tableView.register(UINib(nibName: ListItemViewCell.nibName, bundle: nil), forCellReuseIdentifier: ListItemViewCell.nibName)
		tableView.dataSource = self

		let titleView = TitleView(icon: resource.icon, title: resource.title, color: resource.color)
		self.navigationItem.titleView = titleView
	}
}

// MARK: - Tableview
extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 100
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let viewCell = tableView.dequeueReusableCell(withIdentifier: ListItemViewCell.nibName) as! ListItemViewCell
		return viewCell
	}
	
	
}

