//
//  TitleView.swift
//  star-war-api
//
//  Created by nhatquangz on 09/01/2021.
//
import Foundation
import UIKit

class TitleView: UIView {
	
	var iconImageView = UIImageView()
	var titleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	convenience init(icon: UIImage?, title: String, color: UIColor) {
		self.init()
		iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
		titleLabel.text = title
		iconImageView.tintColor = color
		titleLabel.textColor = color
	}
	
	private func setup() {
		let stackView = UIStackView()
		stackView.spacing = 10
		stackView.addArrangedSubview(iconImageView)
		stackView.addArrangedSubview(titleLabel)
		self.addSubview(stackView)
		stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
		titleLabel.font = UIFont(name: "StarJediSpecialEdition", size: 20)
		iconImageView.contentMode = .scaleAspectFit
		
	}
}
