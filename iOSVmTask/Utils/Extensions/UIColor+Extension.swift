//
//  UIColor+Extension.swift
//  iOSVmTask
//
//

import UIKit

public extension UIColor {

     class func make(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha )
    }

     class func make(hex: String, alpha: CGFloat = 1) -> UIColor {
        // Convert hex string to an integer
        var hexint: UInt32 = 0

        // Create scanner
        let scanner = Scanner(string: hex)

        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexint)

        // Create color object, specifying alpha
        if hex.count <= 4 {
            let divisor = CGFloat(15)
            let red     = CGFloat((hexint & 0xF00) >> 8) / divisor
            let green   = CGFloat((hexint & 0x0F0) >> 4) / divisor
            let blue    = CGFloat( hexint & 0x00F      ) / divisor
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            let divisor = CGFloat(255)
            let red     = CGFloat((hexint & 0xFF0000) >> 16) / divisor
            let green   = CGFloat((hexint & 0xFF00  ) >> 8)  / divisor
            let blue    = CGFloat( hexint & 0xFF    )        / divisor
            return UIColor(red: red, green: green, blue: blue, alpha: alpha )
        }
    }
}

public func UIColorFrom(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
    return UIColor.make(red: red, green: green, blue: blue, alpha: alpha)
}

public func UIColorFrom(hex: String, alpha: CGFloat = 1) -> UIColor {
    return UIColor.make(hex: hex, alpha: alpha)
}

// MARK: - App default color

public extension UIColor {
     class var primaryTextColor: UIColor {
        return UIColor.make(hex: HEXTitleColor)
    }

    class var secondryTextColor: UIColor {
       return UIColor.make(hex: HEXDescriptionColor)
   }

    class var navigationBarColor: UIColor {
       return UIColor.make(hex: HEXNavigationBarcolor)
   }

    class var cellBackgroundColor: UIColor {
       return UIColor.make(hex: HEXCellBackgroundColor)
   }
    class var appBackgroundColor: UIColor {
       return UIColor.make(hex: HEXCellBackgroundColor)
   }
}
