//
//  UIViewController.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    static var storyboardId: String {
        return String(describing: self)
    }
    static func instantiate(from storyboardName: UIStoryboard.Name) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
    func isRootViewController() -> Bool {
        if let array = self.navigationController?.viewControllers {
            if array.count>0 {
                return array[0] == self
            }
        }
        return false
    }
}

extension UIStoryboard {
    enum Name: String {
        case main = "Main"
    }
}

