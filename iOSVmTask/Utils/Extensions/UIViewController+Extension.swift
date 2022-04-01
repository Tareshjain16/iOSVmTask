//
//  UIViewControllor+Extension.swift
//  iOSVmTask
//
//

import Foundation
import UIKit

public extension UIViewController {

    /// Show loader
    func showLoader(isShow: Bool) {
        if isShow {
            let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating()
            loadingIndicator.color = UIColor.navigationBarColor
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: false, completion: nil)
        }
    }

    /// Hide loader
    func hideLoader() {
        if self.presentedViewController?.isKind(of: UIAlertController.self) != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
