//
//  StoryboardLoadable.swift
//  ArtWork
//
//  Created by Dott on 10/10/23.
//

import UIKit

protocol StoryboardLoadable {
    static var storyboardName: String { get }
    static var identifier: String { get }
    static func initFromStoryboard() -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    
    //Set the default storyboardName to "Main"
    static var storyboardName: String {
        return "Main"
    }
    
    static func initFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
