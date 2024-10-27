//
//  BaseViewController.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

import SnapKit

class BaseViewController<View: UIView>: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Components
    
    private let navigationBar = UIView()
    let contentView = View()
    private(set) var titleLabel: UILabel?
    private(set) var subTitleLabel: UILabel?
    private(set) var backButton: UIButton?
    private(set) var actionButton: UIButton?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureGradient()
        configureLayout()
    }
    
    // MARK: - Public Configure Methods
    
    func configureDefaultNavigationBar(title: String? = nil, actionTitle: String? = nil) {
        configureBackButton()
        
        if let title = title {
            configureDefaultTitle(with: title)
        }
        
        if let actionTitle = actionTitle {
            var attributedTitle = AttributedString(actionTitle)
            attributedTitle.font = .body1
            
            var config = UIButton.Configuration.plain()
            config.attributedTitle = attributedTitle
            
            configureActionButton(with: config)
        }
    }
    
    func configureLargeTitleNavigationBar(title: String, font: UIFont, image: UIImage? = nil) {
        configureLargeTitle(with: title, font: font)
        
        if let image = image {
            var config = UIButton.Configuration.plain()
            config.image = image
            
            configureActionButton(with: config)
        }
    }
    
    // MARK: - Private Configure Methods
    
    private func configureViewController() {
        view.backgroundColor = .backgroundPrimary
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func configureGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.secondary.cgColor,
                                UIColor.backgroundPrimary.cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.addSublayer(gradientLayer)
    }
    
    private func configureLayout() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Layout.Component.navigationBar)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureDefaultTitle(with title: String) {
        let label = makeLabel(text: title, font: .heading3)
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel = label
    }
    
    private func configureLargeTitle(with title: String, font: UIFont) {
        let label = makeLabel(text: title, font: font)
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Spacing.Content.padding)
            make.centerY.equalToSuperview()
        }
        titleLabel = label
    }
    
    private func configureBackButton() {
        let button = UIButton()
        button.setImage(.back, for: .normal)
        button.tintColor = .gray09
        
        navigationBar.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Spacing.Content.padding)
            make.centerY.equalToSuperview()
        }
        
        backButton = button
    }
    
    private func configureActionButton(with config: UIButton.Configuration) {
        let button = UIButton()
        button.configuration = config
        button.tintColor = .gray09
        
        navigationBar.addSubview(button)
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
            make.centerY.equalToSuperview()
        }
        
        actionButton = button
    }
    
    // MARK: - Helper Methods
    
    private func makeLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: font)
        label.textColor = .gray09
        return label
    }
}
