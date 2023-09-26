//
//  UICollectionView.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import UIKit

extension UICollectionViewCell {
    static var nibName: String {
        return String(describing: self)
    }
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

