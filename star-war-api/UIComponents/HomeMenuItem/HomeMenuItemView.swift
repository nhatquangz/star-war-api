import Foundation
import UIKit

class HomeMenuItemView: UIView {
	
	let nibName = "HomeMenuItemView"
	@IBOutlet weak var contentView: UIView!
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var goDetailButton: UIButton!
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	convenience init(icon: UIImage?, title: String) {
		self.init()
		iconImageView.image = icon
		titleLabel.text = title
	}
	
	private func setup() {
		Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = self.bounds
		self.clipsToBounds = true
		self.layer.cornerRadius = 5
		contentView.alpha = 0.88
	}
	
	func config(icon: UIImage, title: String) {
		
	}
}
