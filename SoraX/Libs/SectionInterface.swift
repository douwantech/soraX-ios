//
//  CheckoutSectionInterface.swift
//  McDonaldsJapan
//
//  Created by apple on 11/22/19.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit

protocol SectionInterface {
    func cellAndData(indexPath: IndexPath) -> UITableViewCell
    func cellRows() -> Int
    func cellHeight(indexPath: IndexPath) -> CGFloat
    func cellDidSelect(indexPath: IndexPath)
    func cellCanEdit(indexPath: IndexPath) -> Bool
    func cellEditing(indexPath: IndexPath, style: UITableViewCell.EditingStyle)
}

extension SectionInterface {
    func cellCanEdit(indexPath: IndexPath) -> Bool {
        return false
    }
    
    func cellEditing(indexPath: IndexPath, style: UITableViewCell.EditingStyle) {
    }
}

protocol CollectionSectionInterface {
    func cellAndData(indexPath: IndexPath) -> UICollectionViewCell
    func cellRows() -> Int
    func cellSize(indexPath: IndexPath) -> CGSize
    func cellDidSelect(indexPath: IndexPath)
    func cellWillDisplay(indexPath: IndexPath)
    func sectionInsets() -> UIEdgeInsets
    func sectionMinimumLineSpacing() -> CGFloat
    func sectionMinimumInteritemSpacing() -> CGFloat
}

extension CollectionSectionInterface {
    func cellWillDisplay(indexPath: IndexPath) {
    }
}
