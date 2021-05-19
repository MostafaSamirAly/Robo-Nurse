//
//  UIFont+EXt.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/22/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit


struct AppFontName {
    static let regular = "Montserrat-Regular"
    static let bold = "Montserrat-Bold"
    static let italic = "Montserrat-Italic"
    static let medium = "Montserrat-Medium"
    static let semiBold = "Montserrat-SemiBold"
    static let semiBoldItalic = "Montserrat-SemiBoldItalic"
    static let light = "Montserrat-Light"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    @objc class func montserratRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func montserratBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!

    }

    @objc class func montserratItalic(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }

    @objc class func montserratSemiBold(ofSize size: CGFloat) -> UIFont {
         return UIFont(name: AppFontName.semiBold, size: size)!
    }
    @objc class func montserratMedium(ofSize size: CGFloat) -> UIFont {
         return UIFont(name: AppFontName.medium, size: size)!
    }
    
    @objc class func montserratLight(ofSize size: CGFloat) -> UIFont {
         return UIFont(name: AppFontName.light, size: size)!
    }
    
    @objc class func montserratFontWithWeight(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        switch weight {
        case .semibold:
            return UIFont(name: AppFontName.semiBold, size: size)!
        case .bold:
            return UIFont(name: AppFontName.bold, size: size)!
        case .light:
            return UIFont(name: AppFontName.light, size: size)!
        case .medium:
            return UIFont(name: AppFontName.medium, size: size)!
        default:
            return UIFont(name: AppFontName.regular, size: size)!
        }
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(myCoder: aDecoder)
            return
        }
        var fontName = ""
        //print("*******"+fontAttribute)
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.italic
        case "CTFontDemiUsage":
            fontName = AppFontName.semiBold
        case "CTFontMediumUsage":
            fontName = AppFontName.medium
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(montserratRegular(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(montserratBold(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(montserratItalic(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }

        if let semiBoldSystemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
            let mySemiBoldSystemFontMethod = class_getClassMethod(self, #selector(montserratSemiBold(ofSize:))) {
            method_exchangeImplementations(semiBoldSystemFontMethod, mySemiBoldSystemFontMethod)
        }
        
        if let mediumSystemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
            let myMediumSystemFontMethod = class_getClassMethod(self, #selector(montserratMedium(ofSize:))) {
            method_exchangeImplementations(mediumSystemFontMethod, myMediumSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
