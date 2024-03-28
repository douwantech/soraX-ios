//
//  MakePromptCell.swift
//  SoraX
//
//  Created by shuai on 2024/3/28.
//

import UIKit

class MakePromptCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var vPrompt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(prompt: String) {
        vPrompt.text = prompt
    }

    class func calcWidth(with text: String) -> CGFloat {
                                //    左右间距各12
        return H.calTextWidth(text, 12) + 24
    }
}
