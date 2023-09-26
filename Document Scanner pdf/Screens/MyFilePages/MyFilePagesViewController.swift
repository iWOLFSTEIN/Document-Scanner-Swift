//
//  MyFilePagesViewController.swift
//  Document Scanner pdf
//
//  Created by Talha on 16/06/2023.
//

import Combine
import UIKit

protocol FolderPopupViewDelegate {
    func folderPopupView(isHidden: Bool)
}

class MyFilePagesViewController: UIViewController {
    
    @IBOutlet var contentView: MyFilePagesContentView!
    
    var viewModel = MyFilePagesViewModel()
    
    var delegate: FolderPopupViewDelegate?
    
    private var bag = Set<AnyCancellable>()
    
    private var searchBarDefaultXPosition = 0.0
    let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseInOut]
    let duration: TimeInterval = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadDirectories()
        
        contentView.delegate = self
        contentView.textField.delegate = self
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        
        contentView.addFileIcon.addTapGesture(withTarget: self, andAction: #selector(addFile))
        
        viewModel
            .$fileViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.contentView.collectionView.reloadData()
            }
            .store(in: &bag)
        
    }
    
    @objc func addFile(_ sender: UITapGestureRecognizer) {
        showAlertWithTextField()
    }
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Create Folder", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter folder name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first,
               let enteredText = textField.text {
                self.viewModel.createFolder(withName: enteredText)
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func showMoreInfo(_ sender: UITapGestureRecognizer) {
        delegate?.folderPopupView(isHidden: false)
    }
}

extension MyFilePagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleTap(at: indexPath.item)
    }
}

extension MyFilePagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemsCount = viewModel.fileViewModels.count
        
        if itemsCount == 0 {
            collectionView.setEmptyMessage("No Results")
        } else {
            UIView.transition(with: contentView, duration: duration, options: transitionOptions, animations: {
                self.contentView.collectionView.restore()
            }, completion: nil)
        }
        
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FileCollectionViewCell.reusableIdentifier, for: indexPath) as! FileCollectionViewCell
        
        let cellViewModel = viewModel.fileViewModels[indexPath.item]
        cell.setViewModel(cellViewModel)
        cell.moreInfoIcon.addTapGesture(withTarget: self, andAction: #selector(showMoreInfo))
        
        return cell
    }
}

extension MyFilePagesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if let text = textField.text, let textRange = Range(range, in: text) {
               let updatedText = text.replacingCharacters(in: textRange, with: string)
               viewModel.startSearch(withName: updatedText)
           }
        
           return true
       }
}

extension MyFilePagesViewController: SearchBarDelegate {
    func slideToShowSearchBar() {
        let searchBarFinalPosition = contentView.searchBarStackView.center.x
        searchBarDefaultXPosition = searchBarFinalPosition
        
        contentView.searchBarStackView.frame.origin.x = contentView.searchIconIconTray.frame.origin.x
        contentView.searchBarStackView.isHidden = false
        contentView.cancelButtonLabel.isHidden = false
        contentView.settingsIcon.isHidden = true
        
        UIView.transition(with: contentView, duration: duration, options: transitionOptions, animations: {
            self.viewModel.startSearch(withName: "")
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.contentView.searchBarStackView.center.x = searchBarFinalPosition
        } completion: { _ in
            self.contentView.textField.becomeFirstResponder()
        }
    }
    
    func slideToHideSearchBar() {
        let searchBarFinalPosition = contentView.searchIconIconTray.frame.origin.x
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.contentView.searchBarStackView.frame.origin.x = searchBarFinalPosition
        } completion: { _ in
            self.contentView.settingsIcon.isHidden = false
            self.contentView.searchBarStackView.isHidden = true
            self.contentView.cancelButtonLabel.isHidden = true
            self.contentView.searchBarStackView.center.x = self.searchBarDefaultXPosition
            self.contentView.textField.text = ""
        }
        
        self.viewModel.loadDirectories()
    }
}
