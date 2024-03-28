//
//  MakeStyleCell.swift
//  SoraX
//
//  Created by shuai on 2024/3/28.
//

import UIKit

class MakeStyleCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var vWrap: UIView!
    
    var showLayer: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vWrap.backgroundColor = .random()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if showLayer {
            removeGradientBorder()
            addGradientBorder()
        }
    }
    
    func setData(showLayer: Bool) {
        self.showLayer = showLayer
        if !showLayer {
            removeGradientBorder()
        }
    }
    
    func removeGradientBorder() {
        contentView.layer.sublayers?.forEach({ layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        })
    }

    func addGradientBorder() {
        // 1. 创建渐变层
        let gradientLayer = CAGradientLayer()
//        gradientLayer.isHidden = true
        gradientLayer.frame = contentView.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.init(hexString: "#FDC0FF").cgColor, UIColor.init(hexString: "#DDFFC5").cgColor]
        
        // 2. 创建路径层
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1.5
        shapeLayer.path = UIBezierPath(roundedRect: contentView.bounds.insetBy(dx: 0.75, dy: 0.75), cornerRadius: 16).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor // 颜色无所谓，它会被渐变层覆盖
        
        // 3. 添加渐变层和路径层
        contentView.layer.addSublayer(gradientLayer)
        gradientLayer.mask = shapeLayer
    }
}
