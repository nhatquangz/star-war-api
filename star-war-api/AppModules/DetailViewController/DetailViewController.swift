//
//  DetailViewController.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class DetailViewController: TransparentBarViewController {
	
	var tableHeightConstraint: Constraint?
	let disposeBag = DisposeBag()
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.tintColor = viewModel.resourceType.color
	}
	
}

// MARK: - Setup UI
extension DetailViewController {
	func setup() {
		/// Background + Title
		let resourceType = viewModel.resourceType
		self.navigationController?.navigationBar.tintColor = resourceType.color
		self.add(background: resourceType.background)
		let titleView = TitleView(title: viewModel.item.title, color: resourceType.color)
		self.navigationItem.titleView = titleView
		
		/// Description list
		let detailView = UIView()
		detailView.clipsToBounds = true
		detailView.backgroundColor = .white
		detailView.layer.cornerRadius = 5
		detailView.alpha = 0.88
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		
		self.view.addSubview(detailView)
		detailView.addSubview(stackView)
		detailView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(12)
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
			$0.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
		}
		stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(12) }
		
		// Name
		let nameView = TitleView(icon: resourceType.icon, title: viewModel.item.title, color: .black)
		nameView.iconImageView.snp.makeConstraints { $0.width.equalTo(20) }
		nameView.titleLabel.font = UIFont(name: "StarJediSpecialEdition", size: 15)
		nameView.snp.makeConstraints { $0.height.equalTo(35) }
		stackView.addArrangedSubview(nameView)
		
		// General information
		viewModel.generalInformation.asDriver()
			.drive(onNext: { [weak self] information in
				guard let self = self else { return }
				information.forEach { item in
					self.addField(text: item, to: stackView)
					self.addLine(to: stackView)
				}
			})
			.disposed(by: disposeBag)
		
		//
		if let sectionName = viewModel.listSectionName {
			addList(name: sectionName,
					data: viewModel.listSection.asObservable(),
					to: stackView)
		}
	}
}


// MARK: - UI helper function
extension DetailViewController {
	func addLine(to stack: UIStackView) {
		let line = UIView()
		line.backgroundColor = .lightGray
		line.alpha = 0.5
		stack.addArrangedSubview(line)
		line.snp.makeConstraints { $0.height.equalTo(1) }
	}
	
	func addField(text: String, to stack: UIStackView) {
		let label = UILabel()
		label.numberOfLines = 5
		label.font = UIFont.init(name: "Menlo", size: 15)
		label.text = text
		stack.addArrangedSubview(label)
		label.snp.makeConstraints { $0.height.greaterThanOrEqualTo(40) }
	}
	
	func addList(name: String, data: Observable<[Displayable]>, to stack: UIStackView) {
		let label = UILabel()
		label.font = UIFont(name: "Menlo-Bold", size: 15)
		label.text = viewModel.listSectionName
		stack.addArrangedSubview(label)
		label.snp.makeConstraints {
			$0.height.greaterThanOrEqualTo(35)
		}
		
		// Table view
		let tableview = UITableView()
		stack.addArrangedSubview(tableview)
		// Initial height of tableview with low priority
		tableview.snp.makeConstraints { $0.height.equalTo(1).priority(500) }
		/// Using default table view cell
		tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		/// Bind data
		data.asDriver(onErrorJustReturn: [])
			.drive(tableview.rx.items(cellIdentifier: "UITableViewCell", cellType: UITableViewCell.self)) { [weak self] index, viewModel, cell in
				cell.textLabel?.text = viewModel.title
				cell.textLabel?.font = UIFont.init(name: "Menlo", size: 15)
				cell.selectionStyle = .none
				self?.updateListSize(tableview)
			}
			.disposed(by: disposeBag)
		
		/// Handle selection
		tableview.rx.modelSelected(Displayable.self)
			.subscribe(onNext: { [weak self] item in
				let viewModel = DetailViewModel(item: item)
				let vc = DetailViewController(viewModel: viewModel)
				self?.navigationController?.pushViewController(vc, animated: true)
			})
		.disposed(by: disposeBag)
	}
	
	/// Update tableview height
	/// Priority = 750 to make tableview fit inside its parent view
	func updateListSize(_ tableView: UITableView) {
		tableHeightConstraint?.deactivate()
		tableView.snp.makeConstraints {
			tableHeightConstraint = $0.height.equalTo(tableView.contentSize.height).priority(750).constraint
		}
		UIView.animate(withDuration: 0.4) {
			self.view.layoutIfNeeded()
		}
	}
}

