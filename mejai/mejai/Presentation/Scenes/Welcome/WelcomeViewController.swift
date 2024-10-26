//
//  WelcomeViewController.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import Combine
import UIKit

protocol WelcomeViewControllerDelegate: AnyObject {
    func welcomeViewControllerDidFinish()
}

final class WelcomeViewController: BaseViewController<WelcomeView> {
    weak var delegate: WelcomeViewControllerDelegate?
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
                self?.delegate?.welcomeViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        googleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.welcomeViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension WelcomeViewController {
    var appleLoginButton: LoginButton {
        contentView.appleLoginButton
    }
    
    var googleLoginButton: LoginButton {
        contentView.googleLoginButton
    }
}
