//
//  NavigationController.swift
//  SoraX
//
//  Created by shuai on 2024/3/26.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = nil
        navigationBar.backIndicatorImage = UIImage(named: "ico_back")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ico_back")
        navigationBar.backItem?.backButtonTitle = ""
        navigationBar.tintColor = UIColor.black
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: StyleManager.fontByName(.pfb, size: 18)]
        let app = UINavigationBarAppearance()
        app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
        app.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: StyleManager.fontByName(.pfb, size: 18)]
        app.backgroundColor = .clear// 设置导航栏背景色
        app.shadowColor = .clear
        navigationBar.scrollEdgeAppearance = app
        navigationBar.standardAppearance = app
        if #available(iOS 15.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
            app.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: StyleManager.fontByName(.pfb, size: 18)]
            app.backgroundColor = .white// 设置导航栏背景色
            app.shadowColor = .clear
            app.backgroundEffect = nil
            UINavigationBar.appearance().scrollEdgeAppearance = app
            UINavigationBar.appearance().standardAppearance = app
        }
        delegate = self

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

protocol HideNavigationBarProtocol where Self: UIViewController {}

extension NavigationController: UINavigationControllerDelegate {
    //导航控制器将要显示控制器时调用
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if (viewController is HideNavigationBarProtocol){
            self.setNavigationBarHidden(true, animated: true)
        }else {
            self.setNavigationBarHidden(false, animated: true)
        }
    }
}
