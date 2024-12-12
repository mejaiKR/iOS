//
//  SettingsViewController.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import Combine
import UIKit

final class SettingsViewController: BaseViewController<SettingsView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLargeTitleNavigationBar(title: "설정", font: .heading1)
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        logoutButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "로그아웃",
                    message: "정말로 로그아웃하시겠어요?",
                    leftActionText: "그만두기",
                    rightActionText: "로그아웃",
                    rightActionCompletion: {
                        print("fhrmdkdnt")
                    }
                )
            }
            .store(in: &cancellables)
        
        withdrawButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "회원 탈퇴",
                    message: "정말로 탈퇴하시겠어요?\n모든 데이터가 삭제됩니다.",
                    leftActionText: "그만두기",
                    rightActionText: "회원 탈퇴",
                    rightActionCompletion: {
                        print("fhrmdkdnt")
                    },
                    isRightDangerous: true
                )
            }
            .store(in: &cancellables)
    }
}

private extension SettingsViewController {
    var logoutButton: UIButton {
        contentView.logoutButton
    }
    
    var withdrawButton: UIButton {
        contentView.withdrawButton
    }
}
