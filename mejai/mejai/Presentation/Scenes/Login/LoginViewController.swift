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
                guard let self = self else { return }
                switch result {
                case .success:
                    delegate?.loginViewControllerDidFinish()
                case .failure:
                    showAlert(
                        title: "로그인 오류",
                        message: "로그인 시도 중 오류가 발생했어요\n다시 시도해주세요",
                        actionText: "확인"
                    )
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
