//
//  H.swift
//  MarkupAssistant
//
//  Created by apple on 5/4/20.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit
import StoreKit
import Toast_Swift
import SDWebImage
import Photos
import AssetsLibrary

class H: NSObject {
    class func isPro() -> Bool {
        return User.current().vipDays > 0
    }
    
    class func winWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func winHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class func alertAppearance(showCloseButton: Bool = true) -> SCLAlertView.SCLAppearance {
        return SCLAlertView.SCLAppearance(
            kCircleTopPosition: -8,
            kCircleBackgroundTopPosition: -8,
            kCircleHeight: 36,
            kCircleIconHeight: 16,
            kTitleHeight: 0,
            showCloseButton: showCloseButton
        )
    }
    
    class func info(_ content: String) {
        let alertView = SCLAlertView(appearance: H.alertAppearance())
        alertView.viewText.accessibilityIdentifier = "Alert Text"
        alertView.showInfo("", subTitle: content, closeButtonTitle: H.t("common.ok"))
    }
    
    class func toast(_ v: UIView, _ text: String, _ position: ToastPosition = .center) {
        var style = ToastStyle()
        style.backgroundColor = UIColor(red: 0.51, green: 0.51, blue: 0.51,alpha: 0.8)
        style.messageColor = .white
        style.messageFont = .boldSystemFont(ofSize: 14)
        style.horizontalPadding = 20
        v.layer.cornerRadius = 6
        
        v.makeToast(text, duration: 2.0, position: position, style: style)
    }
    
    class func success(_ content: String, _ action: @escaping (() -> Void)) {
        let appearance = SCLAlertView.SCLAppearance(
            kCircleTopPosition: -8,
            kCircleBackgroundTopPosition: -8,
            kCircleHeight: 36,
            kCircleIconHeight: 16,
            kTitleHeight: 0,
            showCloseButton: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.viewText.accessibilityIdentifier = "Alert Text"
        alertView.addButton(H.t("common.ok"), action: action)
        alertView.showSuccess(content, subTitle: content)
    }
    
    
    class func error(_ message: String?) {
        guard let message = message else { return }
        let alertView = SCLAlertView(appearance: H.alertAppearance())
        alertView.viewText.accessibilityIdentifier = "Alert Text"
        alertView.showError("", subTitle: message, closeButtonTitle: H.t("common.ok"))
    }
    
    @objc class func info(_ content: String, cancelTitle cancel:String, confirmTitle confirm:String, _ action: @escaping (() -> Void)) {
        let alertView = SCLAlertView(appearance: H.alertAppearance())
        alertView.addButton(confirm, action: action)
        alertView.viewText.accessibilityIdentifier = "Alert Text"
        alertView.showInfo("", subTitle: content, closeButtonTitle: cancel)
    }
    
    class func error(_ message: String, cancelTitle cancel:String, confirmTitle confirm:String, _ action: @escaping (() -> Void)) {
        let alertView = SCLAlertView(appearance: H.alertAppearance())
        alertView.addButton(confirm, action: action)
        alertView.viewText.accessibilityIdentifier = "Alert Text"
        alertView.showError("", subTitle: message, closeButtonTitle: cancel)
    }
    
    class func t(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    class func tt(_ key: String, args: [CVarArg]) -> String {
        return String(format: NSLocalizedString(key, comment: ""), arguments: args)
    }
    
    class func width(_ view: UIView) -> CGFloat {
        return view.frame.size.width
    }
    
    class func height(_ view: UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    class func top(_ view: UIView) -> CGFloat {
        return view.frame.origin.y
    }
    
    class func bottom(_ view: UIView) -> CGFloat {
        return view.frame.origin.y + view.frame.size.height
    }
    
    class func left(_ view: UIView) -> CGFloat {
        return view.frame.origin.x
    }
    
    class func right(_ view: UIView) -> CGFloat {
        return view.frame.origin.x + view.frame.size.width
    }
    
    class func showShadow(_ v: UIView) {
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        v.layer.shadowRadius = 2
        v.layer.shadowOpacity = 0.2
        v.clipsToBounds = false
        v.superview?.clipsToBounds = false
    }
    
    class func showShadow(_ v: UIView, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float) {
        v.layer.shadowOffset = CGSize(width: width, height: height)
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowRadius = radius
        v.layer.shadowOpacity = opacity
    }
    
    class func calTextHeight(_ text: String, _ size: CGFloat, _ width: CGFloat, _ lineHeight: CGFloat = 0) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        let textString = text as NSString
        var textAttributes: [String: Any] = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]
        let paragraphStyle = NSMutableParagraphStyle()
        if lineHeight > 0 {
            //paragraphStyle.lineSpacing = 5
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineHeightMultiple = lineHeight / UIFont.systemFont(ofSize: size).lineHeight
            textAttributes[convertFromNSAttributedStringKey(NSAttributedString.Key.paragraphStyle)] = paragraphStyle
        }
        let r = textString.boundingRect(with: CGSize(width: width, height: 500), options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(textAttributes), context: nil)
        return max(lineHeight, r.size.height)
    }
    
    class func calTextWidth(_ text: String, _ size: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        let textAttributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]
        let r = text.boundingRect(with: CGSize(width: 500, height: 500), options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(textAttributes), context: nil)
        return r.size.width
    }
    
    class func calAttrTextWidth(_ text: String, _ font: UIFont) -> CGFloat {
        let textAttributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]
        let r = text.boundingRect(with: CGSize(width: 500, height: 500), options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(textAttributes), context: nil)
        return r.size.width
    }
    
    class func calTextHeight(_ text: String, width: CGFloat, style: StyleName) -> CGFloat {
        let (font, paragraph, _, offset) = StyleManager.styleByName(name: style)
        let textString = text as NSString
        var textAttributes: [String: Any] = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]
        textAttributes[convertFromNSAttributedStringKey(NSAttributedString.Key.paragraphStyle)] = paragraph
        textAttributes[convertFromNSAttributedStringKey(NSAttributedString.Key.baselineOffset)] = offset
        let r = textString.boundingRect(with: CGSize(width: width, height: 500), options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(textAttributes), context: nil)
        return ceil(r.size.height)
    }
    
    class func c(_ hex: Int) -> UIColor {
        return UIColor(hex: hex)
    }
    
    class func c(_ values: [CGFloat]) -> UIColor {
        return UIColor(red: values[0]/255.0, green: values[1]/255.0, blue: values[2]/255.0, alpha: values[3])
    }
    
    class func win() -> UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first{
                return window
            }else if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        }
    }
    
    class func isIOS12AndLow() -> Bool {
        if #available(iOS 13.0, *) {
            return false
        } else {
            return true
        }
    }
    
    class func extraBottomHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    class func isFullScreen() -> Bool {
        if extraBottomHeight() > 0 {
            return true
        }
        return false
    }
    
    class func appVersion() -> String {
        let versionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let buildString = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        return "\(versionString).\(buildString)"
    }
    
    class func rating() {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            guard let url = URL(string: "") else { return }
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    class func loadImage(_ imageView: UIImageView, _ url: String, _ placeholder: String = "ico_default") {
        if !url.hasPrefix("http") {
            return imageView.image = UIImage(named: url)
        }
        let placeholderImage = UIImage(named: placeholder)
        imageView.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage, options: .refreshCached)
    }
    
    typealias PrivacyAuthorizerCompletionClosure = (_ granted: Bool)->Void
    
    enum PrivacyAuthorizerStatus {
        case notDetermined                  //尚未授权
        case restricted                     //家长控制
        case denied                         //拒绝
        case authorized                     //已授权
    }
    
    //MARK: 相册相关权限
    
    class func requestPhotoLibraryAuthorization(with completion: @escaping PrivacyAuthorizerCompletionClosure) {
        let status = photoLibraryAuthorizationStatus()
        switch status {
        case .notDetermined:
            if #available(iOS 9.0, *) {
                PHPhotoLibrary.requestAuthorization { (status) in
                    DispatchQueue.main.async {
                        switch status {
                        case .authorized:
                            completion(true)
                        default:
                            completion(false)
                            showAlertWithTitle("无法访问照片", message: authorizationNotice(title: "照片"))
                        }
                    }
                }
            }
        case .restricted,.denied:
            showAlertWithTitle("无法访问照片", message: authorizationNotice(title: "照片"))
        case .authorized:
            completion(true)
        }
    }
    
    //MARK: 相机相关权限
    class func requestCameraAuthorization(with completion: @escaping PrivacyAuthorizerCompletionClosure) {
        let status = cameraAuthorizationStatus()
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                DispatchQueue.main.async {
                    if granted == false {
                        showAlertWithTitle("无法访问相机", message: authorizationNotice(title: "相机"))
                    }
                    completion(granted)
                }
            })
        case .restricted,.denied:
            showAlertWithTitle("无法访问相机", message: authorizationNotice(title: "相机"))
        case .authorized:
            completion(true)
        }
    }
    
    //相册授权状态
    class func photoLibraryAuthorizationStatus() -> PrivacyAuthorizerStatus {
        if #available(iOS 9.0, *) {
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .denied:
                return .denied
            default:
                return .authorized
            }
        } else {
            let status = ALAssetsLibrary.authorizationStatus()
            switch status {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .denied:
                return .denied
            default:
                return .authorized
            }
        }
    }
    
    //相机授权状态
    class func cameraAuthorizationStatus() -> PrivacyAuthorizerStatus {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        default:
            return .authorized
        }
    }
    
    //MARK: 弹窗展示
    class func authorizationNotice(title: String) -> String {
        return "请在iPhone的\"设置-隐私-\(title)\"中允许\(displayName())访问\(title)"
    }

    class func showAlertWithTitle(_ title: String, message: String) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let goAction = UIAlertAction.init(title: "前往设置", style: .default) { (action) in
            if let settingUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingUrl) {
                    UIApplication.shared.open(settingUrl)
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(goAction)
        currentVc()?.present(alertController, animated: true, completion: nil)
    }
    
    class func displayName() -> String {
        Bundle.main.infoDictionary?["CFBundleName"] as! String
    }
    
    class func currentVc(base: UIViewController? = H.win()?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentVc(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentVc(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentVc(base: presented)
        }
        if let split = base as? UISplitViewController{
            return currentVc(base: split.presentingViewController)
        }
        return base
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

extension H {
    class func showLoading(_ view: UIView) {
        let actInd = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        actInd.center = view.center
        actInd.hidesWhenStopped = true
        actInd.style = UIActivityIndicatorView.Style.gray
        view.addSubview(actInd)
        actInd.startAnimating()
    }
    
    class func hideLoading(_ view: UIView) {
        view.subviews.forEach { (v) in
            if v.isKind(of: UIActivityIndicatorView.classForCoder()) {
                v.removeFromSuperview()
            }
        }
    }
    
    class func shareView(view: UIView, callback: @escaping(() -> Void)) -> UIActivityViewController {
        let content = H.t("")
        let ituneURL = "https://apps.apple.com/cn/app/id"
        let smallImage = "https://oss.douwantech.com/assets/images/"
        let imageData = try? Data(contentsOf: URL(string: smallImage)!)
        let uiImage = UIImage(data: imageData!)!
        
        let activityViewController = UIActivityViewController(
            activityItems: [
                content,
                uiImage,
                URL(string: ituneURL)!
            ],
            applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.copyToPasteboard
        ];
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            callback()
        }
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            activityViewController.modalPresentationStyle = .popover
            activityViewController.popoverPresentationController?.sourceView = view
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        return activityViewController
    }
}
