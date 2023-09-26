//
//  FileCollectionViewCell.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import UIKit

class FileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var fileIcon: UIImageView!
    @IBOutlet weak var moreInfoIcon: UIImageView!
    
    func setViewModel(_ viewModel: FileCellViewModel) {
        title.text = viewModel.title
        subTitle.text = viewModel.subtitle
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
