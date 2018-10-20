//
//  Created by Mighty
//  Copyright © 2018 UOB. All rights reserved.
import Foundation
import UIKit
class SegmentedCell: BaseCell {
    static let height: CGFloat = 70.0
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var selectedSkin: Bool = false {
        didSet {
            if selectedSkin {
                titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                titleLabel.textColor = UIColor.white
                iconImageView.image = iconImageView.image!.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.white
                selectionView.backgroundColor = UIColor.white
                selectionView.isHidden = false
            } else {
                titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                titleLabel.textColor = UIColor.darkGray
                if iconImageView.image != nil {
                    iconImageView.image = iconImageView.image!.withRenderingMode(.alwaysTemplate)
                }
                iconImageView.tintColor = UIColor.darkGray
                selectionView.isHidden = true
            }
        }
    }
    func loadData(_ title: String?, iconImage: String?, isSelected: Bool = false) {
        titleLabel.text = nil
        titleLabel.text = title
        if let iconImage = iconImage {
            iconImageView.image = UIImage(named: iconImage)
        }
        selectedSkin = isSelected
    }
}
