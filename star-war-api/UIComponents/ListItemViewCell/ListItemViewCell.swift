//
//  ListItemViewCell.swift
//  star-war-api
//
//  Created by nhatquangz on 08/01/2021.
//

import UIKit

class ListItemViewCell: UITableViewCell {
	
	static let nibName = "ListItemViewCell"
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.layer.cornerRadius = 5
		self.selectionStyle = .none
    }
	
	func config(data: Displayable) {
		iconImageView.image = data.icon
		titleLabel.text = data.title
		subtitleLabel.text = data.subtitle
	}

}
