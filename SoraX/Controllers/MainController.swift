//
//  ViewController.swift
//  SoraX
//
//  Created by shuai on 2024/3/25.
//

import UIKit
import Alamofire

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var vcs :[UIViewController] = []
        let normalFont = UIFont(name: FontName.pfr.rawValue, size: 12)
        let selectFont = UIFont(name: FontName.pfb.rawValue, size: 12)
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            //            NSAttributedString.Key.foregroundColor: UIColor(hexString: "#5A5A65"),
            NSAttributedString.Key.font: normalFont as Any
        ]
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: selectFont as Any,
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "#151323")
        ]
        
        let ExploreVc = ExploreController.createFromStoryboard(storyboard: "Explore")
        let ExploreNav = NavigationController(rootViewController: ExploreVc)
        vcs.append(ExploreNav)
        
        let MakeVc = MakeController.createFromStoryboard(storyboard: "Make")
        let MakeNav = NavigationController(rootViewController: MakeVc)
        vcs.append(MakeNav)
        
        let recordsVc = RecordsController.createFromStoryboard(storyboard: "Records")
        let recordsNav = NavigationController(rootViewController: recordsVc)
        vcs.append(recordsNav)
        
        self.viewControllers = vcs
        tabBar.isHidden = true
        
        let window = UIApplication.shared.windows.first
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        let customTabBar = CustomTabBar(frame: CGRect(x: 11, y: H.winHeight() - bottomPadding - 10 - 59, width: H.winWidth() - 22, height: 59))
        customTabBar.delegate = self
        view.addSubview(customTabBar)
    }

}

extension MainController: CustomTabBarDelegate {
    func switchTabBar(index: Int) {
        selectedIndex = index
    }
}
