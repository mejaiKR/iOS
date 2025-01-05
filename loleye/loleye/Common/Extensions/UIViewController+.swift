//
//  UIViewController+.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String,
        message: String,
        leftActionText: String,
        rightActionText: String,
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil,
        isRightDangerous: Bool = false
    ) {
        let alertViewController = AlertViewController(
            title: title,
            message: message,
            leftActionText: leftActionText,
            rightActionText: rightActionText,
            leftActionCompletion: leftActionCompletion,
            rightActionCompletion: rightActionCompletion,
            isRightDangerous: isRightDangerous
        )
        present(alertViewController, animated: false)
    }
    
    func showAlert(
        title: String,
        message: String,
        actionText: String,
        actionCompletion: (() -> Void)? = nil
    ) {
        let alertViewController = AlertViewController(
            title: title,
            message: message,
            actionText: actionText,
            actionCompletion: actionCompletion
        )
        present(alertViewController, animated: false)
    }
}
