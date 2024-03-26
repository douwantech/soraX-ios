//
//  Extension.swift
//  MarkupAssistant
//
//  Created by apple on 5/4/20.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit

enum StyleType {
    case myForm
}

extension Notification.Name {
    static let LoggedIn = NSNotification.Name("LoggedIn")
    static let LoginOut = NSNotification.Name("LoginOut")
    static let reachabilityChanged = NSNotification.Name("reachabilityChanged")
    static let Purchased = NSNotification.Name("Purchased")
    static let CreateProductSuccess = NSNotification.Name("CreateProductSuccess")
    static let GenerateProductSuccess = NSNotification.Name("GenerateProductSuccess")
    static let DeleteProductSuccess = NSNotification.Name("DeleteProductSuccess")
    static let IncreaseCreditsSuccess = NSNotification.Name("IncreaseCreditsSuccess")
    static let CheckID = NSNotification.Name("CheckID")
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var hexString: String {
        let components: [Int] = {
            let comps = cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UILabel {
    func setTailText(_ text: String?, style: StyleName) {
        self.attributedText = StyleManager.attributeTailText(text: text ?? "", name: style)
    }

    func setText(_ text: String?, style: StyleName) {
        self.attributedText = StyleManager.attributeText(text: text ?? "", name: style)
    }
}

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableViewCell: ReusableView {}

protocol NibLoadable: ReusableView {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}

extension UITableView {
    func registerNibCell<T: NibLoadable>(ofType: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueRegisteredCell<T: ReusableView>(oftype: T.Type, at indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T //Should be safe to force unwrap since reuse ID is derived from class name
    }
}

extension UICollectionView {
    func registerNibCell<T: NibLoadable>(ofType: T.Type) {
        self.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueRegisteredCell<T: ReusableView>(oftype: T.Type, at indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T //Should be safe to force unwrap since reuse ID is derived from class name
    }
}


extension KeyedDecodingContainer {
    public func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
    public func decodeIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}

extension UIButton {
    func setText(_ text: String, style: StyleName, state: UIControl.State = .normal) {
        self.setAttributedTitle(StyleManager.attributeText(text: text, name: style), for: state)
    }
    
    func asTextField() {
        self.backgroundColor = H.c(0xF8F8F8)
        self.layer.cornerRadius = 25
    }
    
    func asTextField(style: StyleType) {
        self.backgroundColor = H.c(0xF8F8F8)
        self.layer.cornerRadius = 20
        self.contentHorizontalAlignment = .left
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func setGradientLayer(startColor: UIColor, endColor: UIColor, startPoint : CGPoint, endPoint: CGPoint){
        let caGradientLayer:CAGradientLayer = CAGradientLayer()
          caGradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        caGradientLayer.locations = [0, 1]
                caGradientLayer.startPoint = startPoint
                caGradientLayer.endPoint = endPoint
                caGradientLayer.frame = self.bounds
        self.layer.insertSublayer(caGradientLayer, at: 0)
        self.layer.masksToBounds = true
    }
}

extension UITextField {
    func asTextField() {
        self.backgroundColor = H.c(0xF8F8F8)
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 5
        self.layer.borderColor = H.c(0xF8F8F8).cgColor
        self.textColor = H.c(0x584B67)
    }
    
    func asTextField(style: StyleType) {
        self.backgroundColor = H.c(0xF8F8F8)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 5
        self.layer.borderColor = H.c(0xF8F8F8).cgColor
        self.textColor = H.c(0x584B67)
    }
}

extension NotificationCenter {
    func reinstall(observer: NSObject, name: Notification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: name, object: nil)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }
}

extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController {
    class func createFromStoryboard(storyboard name: String, identifier: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewControllerIdentifier = identifier ?? String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as! Self
    }
}

extension UIColor {
    static func custom(_ name: ColorName) -> UIColor {
        StyleManager.colorByName(name)
    }
}

extension UIView {
    /// 给 UIView 添加点击事件
    /// - Parameters:
    ///   - target: 事件的接收者
    ///   - action: 事件触发时执行的方法
    func addTapGestureRecognizer(target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
}
