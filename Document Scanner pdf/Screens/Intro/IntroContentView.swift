//
//  IntroContentView.swift
//  Document Scanner pdf
//
//  Created by Talha on 15/06/2023.
//

import UIKit

class IntroContentView: UIView {
    
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet var dotIndicatorImages: [UIImageView]!
    
    var delegate: IntroAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let fontWeight = UIFont.Weight.semibold
        let font = UIFont.systemFont(ofSize: 17, weight: fontWeight)
        continueButton.titleLabel?.font = font
        continueButton.clipsToBounds = true
        continueButton.layer.cornerRadius = 25
    }
    
    @IBAction func continueAction(_ sender: Any) {
        delegate?.continueAction()
    }
    
    func applyGradients() {
        gradientView.applyGradient(colors: [.gradientViewTopColor, .gradientViewBottomColor], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        
        continueButton.applyGradient(colors: [.continueButtonLeftGradient, .continueButtonRightGradient], startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5))
    }
}
