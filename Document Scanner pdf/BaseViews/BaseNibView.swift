//
//  BaseUIView.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import UIKit

class BaseNibView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        uiConfigurations()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        uiConfigurations()
    }
    
    func uiConfigurations() {}
    
    func commonInit() {
        let nib = UINib(nibName: String(describing: Self.self), bundle: nil)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not load BasicTaskTile from nib")
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
