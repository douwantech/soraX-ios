//
//  GuideController.swift
//  SoraX
//
//  Created by shuai on 2024/3/26.
//

import UIKit

class GuideController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .custom(.black15)
    }

    @IBAction func tapGo() {
        view.window?.rootViewController = MainController.createFromStoryboard(storyboard: "Main")
    }
}
