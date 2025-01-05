//
//  SettingsViewController.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import Combine
import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func moveToOnboarding()
}

final class SettingsViewController: BaseViewController<SettingsView> {
    weak var delegate: SettingsViewControllerDelegate?
    private let viewModel: SettingsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLargeTitleNavigationBar(title: "설정", font: .heading1)
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        otherSummonerButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "다른 소환사 감시하기",
                    message: "감시할 소환사는\n언제든지 다시 변경할 수 있습니다.",
                    leftActionText: "취소",
                    rightActionText: "확인",
                    rightActionCompletion: { [weak self] in
                        self?.viewModel.send(.otherSummoner)
                    }
                )
            }
            .store(in: &cancellables)
        
        logoutButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "로그아웃",
                    message: "정말로 로그아웃하시겠어요?",
                    leftActionText: "취소",
                    rightActionText: "로그아웃",
                    rightActionCompletion: { [weak self] in
                        self?.viewModel.send(.logout)
                    }
                )
            }
            .store(in: &cancellables)
        
        withdrawButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "회원 탈퇴",
                    message: "정말로 탈퇴하시겠어요?\n모든 데이터가 삭제됩니다.",
                    leftActionText: "취소",
                    rightActionText: "회원 탈퇴",
                    rightActionCompletion: { [weak self] in
                        self?.viewModel.send(.widhdraw)
                    },
                    isRightDangerous: true
                )
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.isActionDone
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.delegate?.moveToOnboarding()
            }
            .store(in: &cancellables)
    }
}

private extension SettingsViewController {
    var otherSummonerButton: UIButton {
        contentView.otherSummonerButton
    }
    
    var logoutButton: UIButton {
        contentView.logoutButton
    }
    
    var withdrawButton: UIButton {
        contentView.withdrawButton
    }
}
