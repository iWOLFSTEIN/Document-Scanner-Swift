//
//  FileCellViewModel.swift
//  Document Scanner pdf
//
//  Created by Talha on 23/06/2023.
//

import Foundation

class FileCellViewModel {
    
    var title: String
    var path: URL
    var subtitle: String
    
    init(folder: Folder) {
        self.title = folder.name
        self.path = folder.directory
        self.subtitle = folder.itemsCount
    }
    
}
