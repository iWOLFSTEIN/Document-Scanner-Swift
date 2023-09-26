//
//  AppDocumentDirectories.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import Foundation

class DirectoryManager {
    static let shared = DirectoryManager()
    
    var currentWorkingDirectory: URL?
    var defaultAppDirectory: URL?
    
    private init() { setAppDirectory() }
    private let fileManager = FileManager.default
    
    func setAppDirectory() {
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            currentWorkingDirectory = documentDirectory
            let appFolderDirectory = createFolder(withName: appName)
            currentWorkingDirectory = appFolderDirectory
            defaultAppDirectory = appFolderDirectory
        }
    }
    
    func createFolder(withName name: String) -> URL? {
        guard let folderURL = currentWorkingDirectory?.appendingPathComponent(name) else { return nil }
        if fileManager.fileExists(atPath: folderURL.path) { return folderURL }
        
        do {
            try? fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
        }
        
        return folderURL
    }
    
    func contentInFolder(folderPath: String) -> [String] {
        let fileManager = FileManager.default
        
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: folderPath)
            return contents
        } catch {
            return []
        }
    }
}


