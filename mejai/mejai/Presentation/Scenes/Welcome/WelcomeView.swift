//
//  WelcomeView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class WelcomeView: UIView {
    // MARK: - Components
    
    private let bubbleImageView = {
        let imageView = UIImageView()
        imageView.image = .bubble
        imageView.contentMode = .bottom
        return imageView
    }()
    
    private lazy var descriptionLabel = makeLabel(
        text: Strings.Welcome.description,
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
        text: Strings.Welcome.welcomeMessage,
        font: .heading1
    )
    
    let startButton = ConfirmButton(title: "시작하기")
    
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
            make.bottom.equalTo(welcomeStackView.snp.top).offset(0 - Constants.Spacing.xs)
        }
        
        addSubview(bubbleImageView)
        bubbleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding * 2)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(0 - Constants.Spacing.lg)
        }
        
        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Layout.Component.button)
            make.leading.bottom.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
    }
}

private extension WelcomeView {
    func makeLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: font)
        label.textColor = .gray09
        return label
    }
}
