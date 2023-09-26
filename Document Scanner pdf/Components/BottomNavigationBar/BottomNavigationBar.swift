//
//  BottomNavigationBar.swift
//  Document Scanner pdf
//
//  Created by Talha on 16/06/2023.
//

import UIKit

class BottomNavigationBar: BaseNibView {

    @IBOutlet weak var actionsIcon: UIImageView!
    @IBOutlet weak var fileIcon: UIImageView!
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var bodyView: UIView!
    
    func addTapGestureToView<T: UIView>(_ view: T, identifier: String, target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.accessibilityIdentifier = identifier
    }
}

//extension BottomNavigationBar: BottomNavigationBarDelegate {
//    func bottomNavigationBar(isHidden: Bool) {
//        self.isHidden = isHidden
//    }
//}
