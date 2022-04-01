//
//  Helper.swift
//  iOSVmTask
//
//

import Foundation
import UIKit

class Helper: NSObject {
    /**
     Intialize UiViewcontroller as rootview controller
     - Returns: Instance of navigation controller
     */
    class func initializeRootViewController(viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor   = UIColor.navigationBarColor
        navigationController.navigationBar.tintColor = UIColor.white
        let navTitleFont = UIFont.boldSystemFont(ofSize: FONTSIZE14)
        navigationController.navigationBar.titleTextAttributes = [.font: navTitleFont, .foregroundColor: UIColor.white]
        return navigationController
    }

    class func customRightNavItem(_ target: AnyObject, barItem: UINavigationItem, strTitle: String, select: Selector) {
        let buttonEdit: UIButton = UIButton(type: .custom)
        buttonEdit.showsTouchWhenHighlighted = true
        buttonEdit.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        buttonEdit.setTitle(strTitle, for: UIControl.State())
        buttonEdit.addTarget(target, action: select, for: UIControl.Event.touchUpInside)
        let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonEdit)
        barItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
    }
}
