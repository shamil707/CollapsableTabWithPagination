//
//  BaseView.swift
//  UICatalog
//
//  Created by Aung Phyoe on 27/7/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import UIKit
class  BaseView: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
