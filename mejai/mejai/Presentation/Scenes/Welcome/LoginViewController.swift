//
//  LoginViewControllerDelegate.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import Combine
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidFinish()
}

final class LoginViewController: BaseViewController<LoginView> {
    weak var delegate: LoginViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }
    
    // MARK: - Configure Methods
    
    private func configureBindings() {
        appleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        kakaoLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension LoginViewController {
    var appleLoginButton: LoginButton {
        contentView.appleLoginButton
    }
    
    var kakaoLoginButton: LoginButton {
        contentView.kakaoLoginButton
    }
}
