//
//  AlertViewController.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import UIKit

import SnapKit

final class AlertViewController: UIViewController {
    private let buttonAttributes = AttributeContainer([
        .font: UIFont.title3
    ])
    
    private var leftActionCompletion: (() -> Void)?
    private var rightActionCompletion: (() -> Void)?
    private var singleActionCompletion: (() -> Void)?
    
    // MARK: - UI Components
    
    private let containerView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 14.0
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let buttonContainer = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = createLabel()
    private lazy var messageLabel: UILabel = createLabel()
    private lazy var leftButton = createButton()
    private lazy var rightButton = createButton()
    private lazy var singleButton = createButton()
    
    // MARK: - Init
    
    init(
        title: String,
        message: String,
        leftActionText: String,
        rightActionText: String,
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil,
        isRightDangerous: Bool = false
    ) {
        super.init(nibName: nil, bundle: nil)
        
        setupCommon()
        setupAlertView(
            title: title,
            message: message,
            leftActionText: leftActionText,
            rightActionText: rightActionText
        )
        setupActions(
            leftActionCompletion: leftActionCompletion,
            rightActionCompletion: rightActionCompletion
        )
        
        if isRightDangerous {
            rightButton.tintColor = .alertWarning
        }
    }
    
    init(
        title: String,
        message: String,
        actionText: String,
        actionCompletion: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        
        setupCommon()
        setupAlertView(title: title, message: message, actionText: actionText)
        setupActions(singleActionCompletion: actionCompletion)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    // MARK: - Setup Methods
    
    private func setupCommon() {
        view.backgroundColor = .dim
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    private func setupAlertView(
        title: String,
        message: String,
        leftActionText: String,
        rightActionText: String
    ) {
        titleLabel.text = title
        titleLabel.applyTypography(with: .title3)
        messageLabel.text = message
        messageLabel.applyTypography(with: .caption1)
        configureButton(leftButton, withTitle: leftActionText)
        configureButton(rightButton, withTitle: rightActionText)
        [leftButton, rightButton].forEach { buttonContainer.addArrangedSubview($0) }
    }
    
    private func setupAlertView(title: String, message: String, actionText: String) {
        titleLabel.text = title
        titleLabel.applyTypography(with: .title3)
        messageLabel.text = message
        messageLabel.applyTypography(with: .caption1)
        configureButton(singleButton, withTitle: actionText)
        buttonContainer.addArrangedSubview(singleButton)
    }
    
    private func setupActions(
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        self.leftActionCompletion = leftActionCompletion
        self.rightActionCompletion = rightActionCompletion
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    private func setupActions(singleActionCompletion: (() -> Void)? = nil) {
        self.singleActionCompletion = singleActionCompletion
        singleButton.addTarget(self, action: #selector(singleButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.center.equalToSuperview()
        }
        
        [titleLabel, messageLabel, buttonContainer].forEach {
            containerView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createLabel(with title: String? = nil) -> UILabel {
        let label = UILabel()
        label.textColor = .gray09
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .clear
        button.tintColor = .alertSuccess
        return button
    }
    
    private func configureButton(_ button: UIButton, withTitle title: String) {
        button.configuration?.attributedTitle = .init(title, attributes: buttonAttributes)
    }
    
    // MARK: - Animation Methods
    
    func prepareForAnimation() {
        view.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    func animateIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.view.alpha = 1.0
            self?.containerView.transform = .identity
        } completion: { _ in
            completion?()
        }
    }
    
    func animateOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.view.alpha = 0.0
        } completion: { _ in
            completion?()
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func leftButtonTapped() {
        dismiss(animated: true, completion: leftActionCompletion)
    }
    
    @objc private func rightButtonTapped() {
        dismiss(animated: true, completion: rightActionCompletion)
    }
    
    @objc private func singleButtonTapped() {
        dismiss(animated: true, completion: singleActionCompletion)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AlertViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimator(alertViewController: self, isPresenting: true)
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimator(alertViewController: self, isPresenting: false)
    }
}

// MARK: - Unified Animator

class AlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let alertViewController: AlertViewController
    private let isPresenting: Bool
    
    init(alertViewController: AlertViewController, isPresenting: Bool) {
        self.alertViewController = alertViewController
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        if isPresenting {
            return 0.2
        } else {
            return 0.1
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            transitionContext.containerView.addSubview(toView)
            alertViewController.prepareForAnimation()
            alertViewController.animateIn {
                transitionContext.completeTransition(true)
            }
        } else {
            alertViewController.animateOut {
                transitionContext.completeTransition(true)
            }
        }
    }
}
