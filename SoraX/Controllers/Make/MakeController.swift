//
//  GenerateController.swift
//  SoraX
//
//  Created by shuai on 2024/3/25.
//

import UIKit

class MakeController: UIViewController, HideNavigationBarProtocol {
    @IBOutlet weak var vMakeBtn: UIButton!
    @IBOutlet weak var vInput: UITextView!
    @IBOutlet weak var vStyleCollection: UICollectionView!
    @IBOutlet weak var vPromptCollection: UICollectionView!
    @IBOutlet weak var vFirstRatio: UIStackView!
    @IBOutlet weak var vFirstRatioWrap: UIStackView!
    @IBOutlet weak var vSecondRatio: UIStackView!
    @IBOutlet weak var vSecondRatioWrap: UIStackView!
    @IBOutlet weak var vThirdRatio: UIStackView!
    @IBOutlet weak var vThirdRatioWrap: UIStackView!
    @IBOutlet weak var vFourthRatio: UIStackView!
    @IBOutlet weak var vFourthRatioWrap: UIStackView!
    
    var gradientLayers: [CAGradientLayer] = [CAGradientLayer](repeating: CAGradientLayer(), count: 4)
    var ratios: [Double] = [1, 4/3, 4/5, 9/16]
    var currentRatio: Double = 1
    
    var promptDatas: [String] = ["A dog run", "Sunset over a crystal lake", "Sunset over a crystal lake"]
    var selectedStyleIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .custom(.black15)
        vMakeBtn.layer.cornerRadius = 25
        vMakeBtn.clipsToBounds = true
        insertGradientLayer(button: vMakeBtn)
        vInput.contentInset = UIEdgeInsets(top: 15, left: 19, bottom: 15, right: 19)
        vStyleCollection.delegate = self
        vStyleCollection.dataSource = self
        vPromptCollection.delegate = self
        vPromptCollection.dataSource = self
        vStyleCollection.registerNibCell(ofType: MakeStyleCell.self)
        vPromptCollection.registerNibCell(ofType: MakePromptCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = [vFirstRatioWrap, vSecondRatioWrap, vThirdRatioWrap, vFourthRatioWrap].map {
            addGradientBorder(to: $0!, width: 1.5)
            $0?.addTapGestureRecognizer(target: self, action: #selector(handleSelectRatio(_ :)))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.updateRatioUI(with: 0)
        }
    }
    
    func insertGradientLayer(button: UIButton) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [UIColor.init(hexString: "#FDC0FF").cgColor, UIColor.init(hexString: "#DDFFC5").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        if let label = button.titleLabel, let imageView = button.imageView {
            button.layer.insertSublayer(gradientLayer, below: label.layer)
            button.layer.insertSublayer(gradientLayer, below: imageView.layer)
        } else {
            button.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        button.addTarget(self, action: #selector(buttonDidResize), for: .allEvents)
    }
    
    func addGradientBorder(to view: UIView, width: CGFloat) {
        let tag = view.tag
        // 1. 创建渐变层
        let gradientLayer = CAGradientLayer()
        gradientLayer.isHidden = true
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.init(hexString: "#FDC0FF").cgColor, UIColor.init(hexString: "#DDFFC5").cgColor]
        gradientLayers[tag] = gradientLayer
        
        // 2. 创建路径层
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(roundedRect: view.bounds.insetBy(dx: width/2, dy: width/2), cornerRadius: 16).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor // 颜色无所谓，它会被渐变层覆盖
        
        // 3. 添加渐变层和路径层
        view.layer.addSublayer(gradientLayer)
        gradientLayer.mask = shapeLayer
    }
    
    @objc func buttonDidResize(_ button: UIButton) {
        if let gradientLayer = button.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = button.bounds
        }
    }
    
    @objc func handleSelectRatio(_ recognizer: UITapGestureRecognizer) {
        let tag = recognizer.view?.tag
        updateRatioUI(with: tag ?? 0)
    }
    
    func updateRatioUI(with tag: Int) {
        gradientLayers.enumerated().forEach { index, layer in
            layer.isHidden = tag != index
        }
        currentRatio = ratios[tag]
    }
    
}

extension MakeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        if tag == 0 {
            return 6
        } else if tag == 1 {
            return promptDatas.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        if tag == 0 {
            // style collection view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeStyleCell.reuseIdentifier, for: indexPath) as! MakeStyleCell
            cell.setData(showLayer: selectedStyleIndex == indexPath.row)
            return cell
        } else if tag == 1 {
            // prompt collection view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakePromptCell.reuseIdentifier, for: indexPath) as! MakePromptCell
            cell.setData(prompt: promptDatas[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = collectionView.tag
        if tag == 0 {
            return indexPath.row == 0 ? CGSize(width: 88, height: 96) : CGSize(width: 120, height: 96)
        } else if tag == 1 {
            let width = MakePromptCell.calcWidth(with: promptDatas[indexPath.row])
            return CGSize(width: width, height: 33)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let tag = collectionView.tag
        if tag == 0 {
            return 0
        } else if tag == 1 {
            return 8
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = collectionView.tag
        if tag == 0 {
            selectedStyleIndex = indexPath.row
            collectionView.reloadData()
        } else if tag == 1 {
            
        }
    }
}

