//
//  GradientLabel.swift
//  SoraX
//
//  Created by shuai on 2024/3/26.
//

import UIKit

class GradientLabel: UILabel {
    private let gradientLayer = CAGradientLayer()

    var isGradientEnabled: Bool = false {
        didSet {
            updateGradient()
        }
    }

    override var text: String? {
        didSet {
            updateGradient()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }

    override func drawText(in rect: CGRect) {
        if isGradientEnabled {
            setupGradient()
        } else {
            removeGradient()
        }
        super.drawText(in: rect)
    }

    private func setupGradient() {
        // Define gradient colors and direction
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.0, 1.0]

        // Set gradient layer as a mask for text
        let textMask = CATextLayer()
        textMask.font = self.font
        textMask.string = self.text
        textMask.fontSize = self.font.pointSize
        textMask.frame = self.bounds
        textMask.foregroundColor = UIColor.black.cgColor
        textMask.isWrapped = true
        textMask.alignmentMode = .center
        textMask.contentsScale = UIScreen.main.scale

        gradientLayer.mask = textMask
        layer.addSublayer(gradientLayer)
    }

    private func removeGradient() {
        gradientLayer.removeFromSuperlayer()
    }

    private func updateGradient() {
        setNeedsDisplay()
    }
}
