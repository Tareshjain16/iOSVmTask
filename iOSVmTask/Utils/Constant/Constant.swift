//
//  Constant.swift
//  iOSVmTask
//
//

import Foundation
import UIKit

/// Getting width and height of the screen
let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height

let WIDTHFACTOR: CGFloat = WIDTH/320.0
let HEIGHTFACTOR: CGFloat = HEIGHT/568.0

/// Calculate font size as per the diffrent device resolution
let iPad = UIDevice.current.userInterfaceIdiom == .pad
let fontFactor: CGFloat = (iPad ? 2.0 : (WIDTH/320.0))

let FONTSIZE12: CGFloat = 12 * fontFactor
let FONTSIZE13: CGFloat = 13 * fontFactor
let FONTSIZE14: CGFloat = 14 * fontFactor

enum ServerEnvironment: String {
    /// Production URL
    case prodution
    /// Network unavailable message
    case staging
    /// Staging URL
    var value: String {
        switch self {
        case .prodution:
            return "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
        case .staging:
            return ""
        }
    }
}
// *********** Color Hex String ***********//
/// Application color
let HEXTitleColor = "C40202"
let HEXDescriptionColor = "8E8E8E"
let HEXNavigationBarcolor = "C40202"
let HEXCellBackgroundColor = "FFFFFF"

// *********** API Name ***********//

let people = "people"
let room = "rooms"
