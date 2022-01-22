//
//  UIViewController+Extensions.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import UIKit

extension UIViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: Constants.kEmptyString, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: Constants.kOk, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
