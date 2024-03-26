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
        let homeNav = NavigationController(rootViewController: ExploreVc)
        homeNav.tabBarItem.title = H.t("探索")
        homeNav.tabBarItem.setTitleTextAttributes(normalTextAttributes, for: .normal)
        homeNav.tabBarItem.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        let createImage = UIImage(named: "tabbar_home_normal")?.withRenderingMode(.alwaysOriginal)
        let createSelectedImage = UIImage(named: "tabbar_home_select")?.withRenderingMode(.alwaysOriginal)
        homeNav.tabBarItem.image = createImage
        homeNav.tabBarItem.selectedImage = createSelectedImage
        homeNav.tabBarItem.imageInsets = UIEdgeInsets.init(top: 9, left: -0.5, bottom: -9, right: 0.5)
        homeNav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: -2, vertical: 7)
        vcs.append(homeNav)
        
        let GenerateVc = GenerateController.createFromStoryboard(storyboard: "Generate")
        let toolNav = NavigationController(rootViewController: GenerateVc)
        toolNav.tabBarItem.title = H.t("生成")
        toolNav.tabBarItem.setTitleTextAttributes(normalTextAttributes, for: .normal)
        toolNav.tabBarItem.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        let searchImage = UIImage(named: "tabbar_tool_normal")?.withRenderingMode(.alwaysOriginal)
        let searchSelectedImage = UIImage(named: "tabbar_tool_select")?.withRenderingMode(.alwaysOriginal)
        toolNav.tabBarItem.image = searchImage
        toolNav.tabBarItem.selectedImage = searchSelectedImage
        toolNav.tabBarItem.imageInsets = UIEdgeInsets.init(top: 9, left: -0.5, bottom: -9, right: 0.5)
        toolNav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.5, vertical: 7)
        vcs.append(toolNav)
        
        let recordsVc = RecordsController.createFromStoryboard(storyboard: "Records")
        let myNav = NavigationController(rootViewController: recordsVc)
        myNav.tabBarItem.title = H.t("历史记录")
        myNav.tabBarItem.setTitleTextAttributes(normalTextAttributes, for: .normal)
        myNav.tabBarItem.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        let myImage = UIImage(named: "tabbar_my_normal")?.withRenderingMode(.alwaysOriginal)
        let mySelectedImage = UIImage(named: "tabbar_my_select")?.withRenderingMode(.alwaysOriginal)
        myNav.tabBarItem.image = myImage
        myNav.tabBarItem.selectedImage = mySelectedImage
        myNav.tabBarItem.imageInsets = UIEdgeInsets.init(top: 9, left: -0.5, bottom: -9, right: 0.5)
        myNav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 3, vertical: 7)
        vcs.append(myNav)
        
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
