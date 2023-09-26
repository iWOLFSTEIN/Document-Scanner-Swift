//
//  UIView.swift
//  Document Scanner pdf
//
//  Created by Talha on 15/06/2023.
//

import UIKit

extension UIView {
    func applyCornerRadius(cornerRadius: CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addTapGesture(withTarget target: Any?, andAction action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
}
