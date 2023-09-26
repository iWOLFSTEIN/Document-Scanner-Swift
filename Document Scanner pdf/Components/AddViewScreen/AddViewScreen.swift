//
//  AddViewScreen.swift
//  Document Scanner pdf
//
//  Created by Talha on 21/06/2023.
//

import UIKit

class AddViewScreen: BaseNibView {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var importFilesView: UIView!
    @IBOutlet weak var addButtonImageView: UIImageView!
    
    override func uiConfigurations() {
        cameraView.layer.cornerRadius = 25
        photosView.layer.cornerRadius = 25
        importFilesView.layer.cornerRadius = 25
    }
}
