//
//  ExploreCategoryCell.swift
//  SoraX
//
//  Created by shuai on 2024/3/26.
//

import UIKit

class ExploreCategoryCell: UITableViewCell, NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
