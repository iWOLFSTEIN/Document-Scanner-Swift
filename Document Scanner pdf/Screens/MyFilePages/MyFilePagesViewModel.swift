//
//  MyFilePagesViewModel.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import Combine
import Foundation

class MyFilePagesViewModel {
    
    @Published var fileViewModels = [FileCellViewModel]()
    
    private var directoryManager = DirectoryManager.shared
    private var subdirectories = [Folder]() {
        didSet {
            fileViewModels = subdirectories.map({ FileCellViewModel(folder: $0) })
        }
    }
    
    func createFolder(withName name: String) {
        _ = directoryManager.createFolder(withName: name)
        subdirectories = getCurrentDirectoryContent()
    }
    
    func loadDirectories() {
        subdirectories = getCurrentDirectoryContent()
    }
    
    func handleTap(at index: Int) {
        let directory = subdirectories[index]
        DirectoryManager.shared.currentWorkingDirectory = directory.directory
        self.subdirectories = getCurrentDirectoryContent()
    }
        
   private func getCurrentDirectoryContent() -> [Folder] {
        guard let directory = directoryManager.currentWorkingDirectory else { return [] }
        
        var folders: [Folder] = []
        let content: [String] = DirectoryManager.shared.contentInFolder(folderPath: directory.path)
        
        for item in content {
            let subDirectory = directory.appendingPathComponent(item)
            let subFolders = directoryManager.contentInFolder(folderPath: subDirectory.path)
            folders.append(Folder(name: item, directory: subDirectory, itemsCount: subFolders.count))
        }
        
        return folders
    }
    
    func startSearch(withName name: String) {
        subdirectories = []
        guard let defaultAppDirectory = directoryManager.defaultAppDirectory else { return }
        searchFolder(withName: name, havingDirectory: defaultAppDirectory)
    }
    
    func searchFolder(withName name: String, havingDirectory directory: URL) {
        let content: [String] = DirectoryManager.shared.contentInFolder(folderPath: directory.path)
        
        if content.count == 0 { return }
        
        for item in content {
            let subDirectory = directory.appendingPathComponent(item)
            let subFolders = directoryManager.contentInFolder(folderPath: subDirectory.path)
            if item.contains(name) {
                subdirectories.append(Folder(name: item, directory: subDirectory, itemsCount: subFolders.count))
            }
            
            searchFolder(withName: name, havingDirectory: subDirectory)
        }
    }
}
