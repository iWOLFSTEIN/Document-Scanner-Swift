//
//  UICollectionView.swift
//  Document Scanner pdf
//
//  Created by Talha on 26/06/2023.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let textLabel = UILabel()
        textLabel.text = message
        textLabel.textAlignment = .center
        textLabel.layer.zPosition = 1
        textLabel.textColor = .placeholder
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textLabel.sizeToFit()

        self.backgroundView = textLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
