//
//  TabBarViewController.swift
//  Document Scanner pdf
//
//  Created by Talha on 19/06/2023.
//

import UIKit

class TabBarViewController: UIViewController {
    
    @IBOutlet weak var folderPopupView: FolderPopupView!
    @IBOutlet weak var addScreenView: AddViewScreen!
    @IBOutlet var mainBodyView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomNavigationBar: BottomNavigationBar!
    
    var myFilePagesViewController: MyFilePagesViewController!
    var actionsViewController: ActionsViewController!
    
    let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseInOut]
    let duration: TimeInterval = 0.3
    
    var folderPopupViewDefaultPosition: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFilePagesViewController = MyFilePagesViewController.instantiate(from: .main)
        actionsViewController = ActionsViewController.instantiate(from: .main)
        
        myFilePagesViewController.delegate = self
        
        view.backgroundColor = .appBackground
        contentView.addSubview(myFilePagesViewController.view)
        myFilePagesViewController.view.frame = contentView.bounds
        addChild(myFilePagesViewController)
        
        bottomNavigationBar.addTapGestureToView(bottomNavigationBar.addIcon, identifier: "addIcon", target: self, action: #selector(goToAddScreen(_:)))
        bottomNavigationBar.addTapGestureToView(addScreenView.addButtonImageView, identifier: "addButtonImageView", target: self, action: #selector(exitAddScreen(_:)))
        bottomNavigationBar.addTapGestureToView(bottomNavigationBar.fileIcon, identifier: "fileIcon", target: self, action: #selector(goToMyFilePagesScreen(_:)))
        bottomNavigationBar.addTapGestureToView(bottomNavigationBar.actionsIcon, identifier: "actionsIcon", target: self, action: #selector(goToActionsScreen(_:)))
        
        panDownFolderPopupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bottomNavigationBar.bodyView.clipsToBounds = false
        bottomNavigationBar.bodyView.applyCornerRadius(cornerRadius: 20.5, corners: [.topLeft, .topRight])
        
    }
    
    @objc func goToMyFilePagesScreen(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: contentView, duration: duration, options: transitionOptions, animations: {
            if self.view.backgroundColor == UIColor.appBackground {
                DirectoryManager.shared.setAppDirectory()
                //self.myFilePagesViewController.updateSubdirectoriesList()
                self.myFilePagesViewController.contentView.collectionView.reloadData()
            }
            self.view.backgroundColor = UIColor.appBackground
            self.contentView.addSubview(self.myFilePagesViewController.view)
            self.myFilePagesViewController.view.frame = self.contentView.bounds
            self.addChild(self.myFilePagesViewController)
        }, completion: nil)
    }
    
    @objc func goToActionsScreen(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: contentView, duration: duration, options: transitionOptions, animations: {
            self.view.backgroundColor = UIColor.appBackground
            self.contentView.addSubview(self.actionsViewController.view)
            self.actionsViewController.view.frame = self.contentView.bounds
            self.addChild(self.actionsViewController)
        }, completion: nil)
    }
    
    @objc func goToAddScreen(_ sender: UITapGestureRecognizer) {
        self.slideActionButtonToTop(withView: self.addScreenView.cameraView)
        self.slideActionButtonToTop(withView: self.addScreenView.photosView)
        self.slideActionButtonToTop(withView: self.addScreenView.importFilesView)
        
        UIView.transition(with: mainBodyView, duration: duration, options: transitionOptions, animations: {
            self.addScreenView.isHidden = false
            
            let rotationAngle = CGFloat(-Double.pi / 4)
            self.addScreenView.addButtonImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            self.bottomNavigationBar.addIcon.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
        }, completion: nil)
    }
    
    @objc func exitAddScreen(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: mainBodyView, duration: duration, options: transitionOptions, animations: {
            self.addScreenView.isHidden = true
            
            self.addScreenView.addButtonImageView.transform = .identity
            self.bottomNavigationBar.addIcon.transform = .identity
        }, completion: nil)
    }
    
    @objc func folderPopViewPanDown(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            UIView.animate(withDuration: 0.3) {
                self.folderPopupView.bodySubContainer.center.y = self.mainBodyView.bounds.height + (self.folderPopupView.bodySubContainer.bounds.height / 2)
            }
        case .ended:
            UIView.transition(with: mainBodyView, duration: duration, options: transitionOptions, animations: {
                self.folderPopupView.isHidden = true
            }, completion: nil)
            
            folderPopupView.bodySubContainer.center.y = folderPopupViewDefaultPosition
        default:
            break
        }
    }
    
    func slideActionButtonToTop(withView view: UIView) {
        let viewFinalPosition = view.center.y
        
        view.center.y = addScreenView.importFilesView.center.y
        
        UIView.animate(withDuration: 0.3) {
            view.center.y = viewFinalPosition
        }
    }
    
    func slideFolderPopViewVertically(withInitialPosition initialPosition: Double, andFinalPosition finalPosition: Double) {
        folderPopupView.bodySubContainer.center.y = initialPosition
        
        UIView.animate(withDuration: 0.3) {
            self.folderPopupView.bodySubContainer.center.y = finalPosition
        }
    }
    
    func panDownFolderPopupView() {
        let panDownGesture = UIPanGestureRecognizer(target: self, action: #selector(folderPopViewPanDown(_:)))
        folderPopupView.bodySubContainer.isUserInteractionEnabled = true
        folderPopupView.addGestureRecognizer(panDownGesture)
    }
}

extension TabBarViewController: FolderPopupViewDelegate {
    func folderPopupView(isHidden: Bool) {
        
        let folderPopupViewInitialPosition = mainBodyView.bounds.height
        let folderPopupViewFinalPosition = folderPopupView.bodySubContainer.center.y
        folderPopupViewDefaultPosition = folderPopupViewFinalPosition
        
        slideFolderPopViewVertically(withInitialPosition: folderPopupViewInitialPosition, andFinalPosition: folderPopupViewFinalPosition)
        
        UIView.transition(with: mainBodyView, duration: duration, options: transitionOptions, animations: {
            self.folderPopupView.isHidden = isHidden
        }, completion: nil)
    }
}
