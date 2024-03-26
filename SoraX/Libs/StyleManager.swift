//
//  StyleManager.swift
//  McDonaldsJapan
//
//  Created by apple on 1/27/20.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit

enum StyleName: String {
    case link = "link"
}

enum FontName: String {
    case system = "system"
    case pfr = "PingFangSC-Regular"
    case pfb = "PingFangSC-Semibold"
    case pfm = "PingFangSC-Medium"
    case grs = "Gilroy-SemiBold"
    case gr = "Gilroy-Regular"
    case grb = "Gilroy-Black"
}

enum ColorName {
    case black, white, darkGrey, segumen, price, cancel, black85, black45, black15

    func toUIColor() -> UIColor {
        switch self {
        case .black:
            return UIColor(hexString: "#000000")
        case .white:
            return UIColor(hexString: "#FFFFFF")
        case .darkGrey:
            return UIColor(hexString: "2B2D3A")
        case .segumen:
            return UIColor(hexString: "7F8188")
        case .price:
            return UIColor(hexString: "FA8514")
        case .cancel:
            return UIColor(hexString: "87888A")
        case .black85:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        case .black45:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        case .black15:
            return UIColor(hexString: "#151518")
        }
    }
}

struct Style {
    var fontName: FontName
    var fontSize: CGFloat
    var lineHeight: CGFloat
    var colorName: ColorName
    var alignment: NSTextAlignment = .left

    init(_ fontName: FontName, _ fontSize: CGFloat, _ lineHeight: CGFloat, _ colorName: ColorName, _ alignment: NSTextAlignment) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.lineHeight = lineHeight
        self.colorName = colorName
        self.alignment = alignment
    }

    init(_ fontName: FontName, _ fontSize: CGFloat, _ lineHeight: CGFloat, _ colorName: ColorName) {
        self.init(fontName, fontSize, lineHeight, colorName, .left)
    }
}

class StyleManager: NSObject {
    static var debug: Bool = false

    class func styleValueByName(name: StyleName) -> Style {
        switch name {
        case .link:
            return Style(.system, 13, 14, .black, .center)
        }
    }

    class func colorByName(_ name: ColorName) -> UIColor {
        if debug { return UIColor.red }
        return name.toUIColor()
    }

    class func fontByName(_ fontName: FontName, size: CGFloat) -> UIFont {
        var font = UIFont(name: fontName.rawValue, size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }

    class func styleByName(name: StyleName) -> (UIFont, NSMutableParagraphStyle, UIColor, CGFloat) {
        let style = styleValueByName(name: name)
        let font = fontByName(style.fontName, size: style.fontSize)
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = style.alignment
        paragraph.lineBreakMode = .byWordWrapping
        let color = colorByName(style.colorName)
        return (font, paragraph, color, 0)
    }

    class func createAttributeString(text: String, name: StyleName, font: UIFont, style: NSMutableParagraphStyle, color: UIColor, offset: CGFloat) -> NSMutableAttributedString {
        let content = debug ? name.rawValue : text
        let attributeString = NSMutableAttributedString(string: content)
        attributeString.addAttribute(.font, value: font, range: NSRange(location: 0, length: content.count))
        attributeString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: content.count))
        attributeString.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: content.count))
        attributeString.addAttribute(.baselineOffset, value: offset, range: NSRange(location: 0, length: content.count))
        if debug {
            attributeString.addAttribute(.backgroundColor, value: UIColor.green, range: NSRange(location: 0, length: content.count))
        }
        return attributeString
    }

    class func attributeText(text: String, name: StyleName) -> NSMutableAttributedString {
        let (font, style, color, offset) = styleByName(name: name)
        return createAttributeString(text: text, name: name, font: font, style: style, color: color, offset: offset)
    }

    class func attributeTailText(text: String, name: StyleName) -> NSMutableAttributedString {
        let (font, style, color, offset) = styleByName(name: name)
        style.lineBreakMode = .byTruncatingTail
        return createAttributeString(text: text, name: name, font: font, style: style, color: color, offset: offset)
    }

    class func textWithLineSpace(text: String, name: StyleName, space: CGFloat) -> NSMutableAttributedString {
        let (font, style, color, offset) = styleByName(name: name)
        style.lineSpacing = space
        return createAttributeString(text: text, name: name, font: font, style: style, color: color, offset: offset)
    }

    class func textWithoutBaseline(text: String, name: StyleName) -> NSMutableAttributedString {
        let (font, style, color, _) = styleByName(name: name)
        let value = styleValueByName(name: name)
        style.lineHeightMultiple = value.lineHeight / font.lineHeight
        return createAttributeString(text: text, name: name, font: font, style: style, color: color, offset: 0)
    }
}
