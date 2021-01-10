//
//  TabbarViewController.swift
//  star-war-api
//
//  Created by nhatquangz on 07/01/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: TransparentBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
}


// MARK: - Setup
extension HomeViewController {
	func setup() {
		self.navigationController?.isNavigationBarHidden = true
		
		/// Add background view
		self.add(background: UIImage(named: "starwar-4"))
		
		/// Star Wars title
		let titleLabel = UILabel()
		titleLabel.font = UIFont(name: "StarJediSpecialEdition", size: 45)
		titleLabel.text = "STAR WARS"
		self.view.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (make) in
			make.centerY.equalToSuperview().multipliedBy(0.5)
			make.centerX.equalToSuperview()
		}
		
		/// Menu items
		let menuStackView = UIStackView()
		menuStackView.axis = .vertical
		menuStackView.spacing = 23
		self.view.addSubview(menuStackView)
		menuStackView.snp.makeConstraints { (make) in
			make.centerX.centerY.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(0.6).priority(750)
			make.width.lessThanOrEqualTo(250)
		}
		for item in StarWarsResources.allCases {
			let itemView = HomeMenuItemView(icon: item.icon, title: item.title)
			menuStackView.addArrangedSubview(itemView)
			itemView.snp.makeConstraints { $0.height.equalTo(50) }
			_ = itemView.goDetailButton.rx.tap.asDriver()
				.throttle(.seconds(1))
				.drive(onNext: { [weak self] in
					let listViewController = ListViewController(resourceType: item)
					self?.navigationController?.pushViewController(listViewController, animated: true)
				})
		}
	}
}

