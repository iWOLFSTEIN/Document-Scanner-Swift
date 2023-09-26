//
//  MyFilePagesContentView.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import UIKit

protocol SearchBarDelegate {
    func slideToShowSearchBar()
    func slideToHideSearchBar()
}

class MyFilePagesContentView: UIView {
    
    @IBOutlet weak var searchBarStackView: UIStackView!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var cancelButtonLabel: UILabel!
    @IBOutlet weak var lockIconIconTray: UIImageView!
    @IBOutlet weak var searchIconIconTray: UIImageView!
    @IBOutlet weak var searchIconTextField: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addFileIcon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: SearchBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: FileCollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FileCollectionViewCell.reusableIdentifier)
        
        let insets = UIEdgeInsets(top: 42.5, left: 32.5, bottom: 42.5, right: 32.5)
        collectionView.contentInset = insets
        
        textField.borderStyle = .none
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholder,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let attributedPlaceholder = NSAttributedString(string: "Search by folder name", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        
        searchIconIconTray.addTapGesture(withTarget: self, andAction: #selector(slideToShowSearchBar))
        cancelButtonLabel.addTapGesture(withTarget: self, andAction: #selector(slideToHideSearchBar))
    }
    
    @objc func slideToShowSearchBar(_ sender: UITapGestureRecognizer) {
        delegate?.slideToShowSearchBar()
    }
    
    @objc func slideToHideSearchBar(_ sender: UITapGestureRecognizer) {
        delegate?.slideToHideSearchBar()
    }
}
