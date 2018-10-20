//
//  ViewController.swift
//  CollapsableTabOnNavView
//
//  Created by Shamil Yusuf on 14/10/18.
//  Copyright © 2018 MiteSolution. All rights reserved.
import Foundation
import UIKit
protocol ViewControllerDelegate: class {
    func onTabClick(selectedSegment: Int)
}

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var selectedSegment: Int = 0
    weak var delegate: ViewControllerDelegate?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main Title"
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.barStyle = .black
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24, weight: .bold), NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(SegmentedCell.nib, forCellWithReuseIdentifier: SegmentedCell.reuseIdentifier)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let value = self.navigationController?.isNavigationBarHidden {
            if value {
                imageView.image = #imageLiteral(resourceName: "FXLandingSmall")
            } else {
                imageView.image = #imageLiteral(resourceName: "FxLandingBg")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segureIDenitifier" {
            if let pageVC = segue.destination as? PaginationViewController {
                pageVC.viewController = self
                pageVC.subDelegate = self
            }
        }
    }
}
extension ViewController: UICollectionViewDataSource {
    func getDatalist() -> [BaseModel] {
        let tab1 = BaseModel(title: "tab1", icon: "convert-currency-selected-white")
        let tab2 = BaseModel(title: "tab2", icon: "view-rates-selected-white")
        let tab3 = BaseModel(title: "tab3", icon: "view-account-selected-white")
        let tab4 = BaseModel(title: "tab4", icon: "manage-alerts-selected-white")
        return [tab1, tab2, tab3, tab4]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedCell.reuseIdentifier, for: indexPath) as!  SegmentedCell
        var selected = false
        if selectedSegment == indexPath.row {
            selected = true
        }
        let model = self.getDatalist()
        cell.loadData(model[indexPath.row].title, iconImage: model[indexPath.row].icon, isSelected: selected)
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(4), height: SegmentedCell.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero // margin between cells UIEdgeInsetsMake(top, left, bottom, right)
    }
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSegment = indexPath.row
        for cell in collectionView.visibleCells {
            if let tempCell = cell as? SegmentedCell {
                tempCell.selectedSkin = false
            }
        }
        collectionView.reloadItems(at: [indexPath])
        self.delegate?.onTabClick(selectedSegment: selectedSegment)
    }
}
extension ViewController: PaginationViewControllerDelegate {
    func onNext(selectedIndex: Int) {
        self.collectionView(collectionView, didSelectItemAt: IndexPath(row: selectedIndex, section: 0))
    }
}
