//
//  CustomTabBar.swift
//  SoraX
//
//  Created by shuai on 2024/3/26.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func switchTabBar(index: Int)
}

class CustomTabBar: UIStackView, NibOwnerLoadable {
    @IBOutlet weak var vExploreStack: UIStackView!
    @IBOutlet weak var vExploreImg :UIImageView!
    @IBOutlet weak var vExploreTitle :UILabel!
    @IBOutlet weak var vMakeStack: UIStackView!
    @IBOutlet weak var vMakeImg :UIImageView!
    @IBOutlet weak var vMakeTitle :UILabel!
    @IBOutlet weak var vRecordStack: UIStackView!
    @IBOutlet weak var vRecordImg :UIImageView!
    @IBOutlet weak var vRecordTitle :UILabel!

    weak var delegate: CustomTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        loadNibContent()
        layer.cornerRadius = bounds.height / 2
        backgroundColor = UIColor(hexString: "#1C1D28").withAlphaComponent(0.3)
        layer.borderColor = UIColor(hexString: "#FDC0FF").withAlphaComponent(0.12).cgColor
        layer.borderWidth = 0.5
        vExploreStack.addTapGestureRecognizer(target: self, action: #selector(handleTapItem(_ :)))
        vMakeStack.addTapGestureRecognizer(target: self, action: #selector(handleTapItem(_ :)))
        vRecordStack.addTapGestureRecognizer(target: self, action: #selector(handleTapItem(_ :)))
        updateUI(with: 0)
    }
    
    @objc func handleTapItem(_ recognizer: UITapGestureRecognizer) {
        let tag = recognizer.view?.tag ?? 0
        delegate?.switchTabBar(index: tag)
        updateUI(with: tag)
    }
    
    func updateUI(with tag: Int) {
        vExploreImg.image = UIImage(named: "tabbar_explore_" + (tag == 0 ? "on" : "off"))
        vExploreTitle.textColor = tag == 0 ? .black : .gray
        vMakeImg.image = UIImage(named: "tabbar_make_" + (tag == 1 ? "on" : "off"))
        vMakeTitle.textColor = tag == 1 ? .black : .gray
        vRecordImg.image = UIImage(named: "tabbar_record_" + (tag == 2 ? "on" : "off"))
        vRecordTitle.textColor = tag == 2 ? .black : .gray
    }
}

