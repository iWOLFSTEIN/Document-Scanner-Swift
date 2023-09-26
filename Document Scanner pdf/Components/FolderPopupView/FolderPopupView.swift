//
//  FolderPopupView.swift
//  Document Scanner pdf
//
//  Created by Talha on 21/06/2023.
//

import UIKit

class FolderPopupView: BaseNibView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var bodySubContainer: UIView!
    
    override func uiConfigurations() {
        bodySubContainer.clipsToBounds = true
        bodySubContainer.layer.cornerRadius = 20.5
    }
}

