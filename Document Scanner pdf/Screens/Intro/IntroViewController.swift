//
//  IntroViewController.swift
//  Document Scanner pdf
//
//  Created by Talha on 15/06/2023.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet var contentView: IntroContentView!
    
    let viewModel = IntroViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.applyGradients()
    }
    
    func slideFromLeftToRight(withViews content: UIView) {
        var subview: UIView = UIView()
        subview = content
        
        let boundsWidth = contentView.bounds.width
        subview.center.x = boundsWidth + subview.bounds.width / 2
        
        UIView.animate(withDuration: 0.5, animations: {
            subview.center.x = boundsWidth / 2
        })
    }

    func animatePageIndicator() {
        let animationOptions: UIImageView.AnimationOptions = [.transitionCrossDissolve, .curveEaseInOut]
        let duration: TimeInterval = 0.5
        
        for (index, imageView) in self.contentView.dotIndicatorImages.enumerated() {
            imageView.image = UIImage(named: "Ellipse 792")
            
            if index == self.viewModel.animationCounter + 1 {
                UIImageView.transition(with: imageView, duration: duration, options: animationOptions) {
                    imageView.image = UIImage(named: "Group 262")
                }
            }
        }
    }
}

extension IntroViewController: IntroAction {
    func continueAction() {
        if viewModel.animationCounter < 2 {
            
            let title = viewModel.introModelArray[viewModel.animationCounter].title
            let subTitle = viewModel.introModelArray[viewModel.animationCounter].subTitle
            let image = viewModel.introModelArray[viewModel.animationCounter].image
            
            contentView.introImage.image = UIImage(named: image)
            slideFromLeftToRight(withViews: contentView.introImage)
            
            contentView.title.text = title
            slideFromLeftToRight(withViews: contentView.title)
            
            contentView.subTitle.text = subTitle
            slideFromLeftToRight(withViews: contentView.subTitle)
            
            animatePageIndicator()
            
            viewModel.animationCounter += 1
        }
        else {
            let tabBarViewController = TabBarViewController.instantiate(from: .main)
            navigationController?.pushViewController(tabBarViewController, animated: true)
        }
    }
}
