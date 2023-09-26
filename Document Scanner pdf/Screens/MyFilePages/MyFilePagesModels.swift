//
//  MyFilePagesModels.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import Foundation

struct Folder {
    var name: String
    var directory: URL
    var itemsCount: String
    
    init(name: String, directory: URL, itemsCount: Int) {
        self.name = name
        self.directory = directory
        if itemsCount == 0 {
            self.itemsCount = "No items"
        } else {
            self.itemsCount = "\(String(itemsCount)) items"
        }
    }
}
