//
//  Created by Mighty
//  Copyright © 2018 UOB. All rights reserved.
import UIKit

class PickerView: BaseView {
    static func viewFromNib() -> PickerView {
        return nib.instantiate(withOwner: nil, options: nil).first as! PickerView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
