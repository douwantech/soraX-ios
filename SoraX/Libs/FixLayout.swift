//
//  FixLayout.swift
//  ArtWork
//
//  Created by Dott on 10/10/23.
//

import UIKit
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let LayoutSCALE = screenWidth / 375

extension NSLayoutConstraint {
    
    @IBInspectable
    var adapterScreen: Bool {
        set {
            if newValue {
                self.constant = self.constant * LayoutSCALE
            }
        } get {
            return true
        }
    }
}
