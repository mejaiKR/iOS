//
//  LoginView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class LoginView: UIView {
    // MARK: - Components
    
    private let bubbleImageView = {
        let imageView = UIImageView()
        imageView.image = .bubble
        imageView.contentMode = .bottom
        return imageView
    }()
    
    private lazy var descriptionLabel = makeLabel(
        text: Strings.Login.description,
        font: .title3
    )
    
    private let welcomeStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var appNameLabel = makeLabel(
        text: Strings.appName,
        font: .logo
    )
    
    private lazy var welcomeMessageLabel = makeLabel(
        text: Strings.Login.welcomeMessage,
        font: .heading1
    )
    
    private let socialStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var socialMessageLabel = makeLabel(
        text: Strings.Login.socialMessage,
        font: .caption1,
        color: .gray04
    )
    
    private lazy var leadingLine = makeLine()
    
    private lazy var trailingLine = makeLine()
    
    let appleLoginButton = LoginButton(socialType: .apple)
    
    let googleLoginButton = LoginButton(socialType: .google)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Methods
    
    private func configureLayout() {
        [appNameLabel, welcomeMessageLabel].forEach { welcomeStackView.addArrangedSubview($0) }
        addSubview(welcomeStackView)
        welcomeStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(welcomeStackView.snp.top).offset(-8)
        }
        
        addSubview(bubbleImageView)
        bubbleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-42)
        }
        
        addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.bottom.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(googleLoginButton.snp.top).offset(-8)
        }
        
        [leadingLine, socialMessageLabel, trailingLine]
            .forEach { socialStackView.addArrangedSubview($0) }
        addSubview(socialStackView)
        socialStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-28)
        }
        
        leadingLine.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(1)
        }
        
        trailingLine.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(1)
        }
    }
}

private extension LoginView {
    func makeLabel(text: String, font: UIFont, color: UIColor = .gray09) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: font)
        label.textColor = color
        return label
    }
    
    func makeLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray03
        return view
    }
}
