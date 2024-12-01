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
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        appleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.loginButtonDidTap(.apple))
            }
            .store(in: &cancellables)
        
        kakaoLoginButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.loginButtonDidTap(.kakao))
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.loginResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.loginViewControllerDidFinish()
                case .failure:
                    print("alert")
                }
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
