//
//  StateView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class StateView: UIStackView {
    enum State {
        case empty
        case error
        
        var image: UIImage {
            switch self {
            case .empty:    UIImage.empty
            case .error:    UIImage.error
            }
        }
    }
    
    // MARK: - Components
    
    private let stateImageView = {
        let imageView = UIImageView()
        imageView.image = .empty
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.textColor = .gray04
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    init(state: State? = nil, message: String? = nil) {
        super.init(frame: .zero)
        setupStackView()
        configure(state: state, message: message)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupStackView() {
        axis = .vertical
        spacing = 8
        alignment = .center
        
        addArrangedSubview(stateImageView)
        addArrangedSubview(messageLabel)
    }
    
    // MARK: - Configure Methods
    
    func configure(state: State?, message: String?) {
        stateImageView.image = state?.image
        messageLabel.text = message
        messageLabel.applyTypography(with: .body2)
    }
}
