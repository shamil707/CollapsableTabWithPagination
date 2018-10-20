//
//  PageViewController.swift
//  CollapsableTabOnNavView
//
//  Created by Shamil Yusuf on 20/10/18.
//  Copyright © 2018 MiteSolution. All rights reserved.
//

import Foundation
import UIKit
enum controllerList {
    case page1, page2, page3, page4
}
protocol PaginationViewControllerDelegate: class {
    func onNext(selectedIndex: Int)
}

class PaginationViewController: UIPageViewController {
    var controller: UIViewController!
    weak var subDelegate: PaginationViewControllerDelegate?
    var viewController: ViewController?
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(step: .page1),
            self.getViewController(step: .page2),
            self.getViewController(step: .page3),
            self.getViewController(step: .page4)
        ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        if pages.first != nil {
            setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        }
        viewController?.delegate = self
    }
    func getViewController(step: controllerList = .page1) -> UIViewController {
        let bundle = UIStoryboard(name: "Main", bundle: nil)
        switch step {
        case .page1:
            controller = bundle.instantiateViewController(withIdentifier: "viewController1")
            return controller
        case .page2:
            controller = bundle.instantiateViewController(withIdentifier: "viewController2")
            return controller
        case .page3:
            controller = bundle.instantiateViewController(withIdentifier: "viewController3")
            return controller
        case .page4:
            controller = bundle.instantiateViewController(withIdentifier: "viewController4")
            return controller
        }
    }
}
extension PaginationViewController: UIPageViewControllerDelegate {
    
}
extension PaginationViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        self.subDelegate?.onNext(selectedIndex: viewControllerIndex)
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return pages.last
        }
        guard pages.count > previousIndex else {
            return nil
        }
        return pages[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        self.subDelegate?.onNext(selectedIndex: viewControllerIndex)
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return pages.first
        }
        guard pages.count > nextIndex else {
            return nil
        }
        return pages[nextIndex]
    }
}
extension PaginationViewController: ViewControllerDelegate {
    func onTabClick(selectedSegment: Int) {
        self.setViewControllers([pages[selectedSegment]], direction: .forward, animated: true, completion: nil)
    }
}
