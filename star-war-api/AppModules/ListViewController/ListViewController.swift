//
//  ListViewController.swift
//  star-war-api
//
//  Created by nhatquangz on 07/01/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ListViewController: TransparentBarViewController {
	
	let tableView = UITableView()
	let refreshControl = UIRefreshControl()
	
	let disposeBag = DisposeBag()
	let resourceType: StarWarsResources
	let viewModel: ListViewModel
	
	init(resourceType: StarWarsResources) {
		self.resourceType = resourceType
		viewModel = ListViewModel(resourceType: resourceType)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.tintColor = resourceType.color
	}
}

// MARK: - Setup
extension ListViewController {
	func setup() {
		self.navigationController?.isNavigationBarHidden = false
		
		let titleView = TitleView(icon: resourceType.icon, title: resourceType.title, color: resourceType.color)
		self.navigationItem.titleView = titleView
		
		/// Background
		self.add(background: resourceType.background)
		
		/// Tableview
		self.view.addSubview(tableView)
		tableView.refreshControl = refreshControl
		refreshControl.tintColor = resourceType.color
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
		tableView.snp.makeConstraints {
			$0.leading.trailing.bottom.equalToSuperview()
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
		}
		tableView.register(UINib(nibName: ListItemViewCell.nibName, bundle: nil), forCellReuseIdentifier: ListItemViewCell.nibName)
		
		tableView.dataSource = self
		tableView.delegate = self
		
		refreshControl.rx.controlEvent(.valueChanged)
			.throttle(.seconds(3), scheduler: MainScheduler.instance)
			.bind(to: viewModel.refreshData)
			.disposed(by: disposeBag)
		
		viewModel.refreshView.asObservable()
			.subscribe(onNext: { [weak self] in
				guard let self = self else { return }
				UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
					self.tableView.reloadData()
				}, completion: nil)
				self.refreshControl.endRefreshing()
			})
			.disposed(by: disposeBag)
		
		viewModel.refreshData.onNext(())
	}
}

// MARK: - Tableview
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dataSource.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let viewCell = tableView.dequeueReusableCell(withIdentifier: ListItemViewCell.nibName) as! ListItemViewCell
		if let data = viewModel.dataSource.value[safe: indexPath.row] {
			viewCell.config(data: data)
		}
		
		/// Load more when reaching bottom
		if indexPath.row == viewModel.dataSource.value.count - 3 {
			viewModel.loadData.onNext(())
		}
		return viewCell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let item = viewModel.dataSource.value[safe: indexPath.row] else { return }
		let viewModel = DetailViewModel(item: item)
		let detailViewController = DetailViewController(viewModel: viewModel)
		self.navigationController?.pushViewController(detailViewController, animated: true)
	}
	
}

