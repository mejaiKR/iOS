//
//  SettingsView.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class SettingsView: UIView {
    // MARK: - Components
    
    lazy var otherSummonerButton = createButton(with: "다른 소환사 감시하기")
    
    lazy var logoutButton = createButton(with: "로그아웃")
    
    lazy var withdrawButton = createButton(with: "회원 탈퇴")
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(otherSummonerButton)
        otherSummonerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(otherSummonerButton.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        addSubview(withdrawButton)
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}

private extension SettingsView {
    func createButton(with title: String) -> UIButton {
        let button = UIButton()
        button.configuration = .plain()
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .title2
        button.configuration?.attributedTitle = attributedTitle
        button.contentHorizontalAlignment = .leading
        button.tintColor = .gray09
        return button
    }
}
