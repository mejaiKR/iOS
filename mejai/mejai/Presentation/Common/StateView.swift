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
        label.applyTypography(with: .body2)
        label.textColor = .gray04
        return label
    }()
    
    // MARK: - Init
    
    init(state: State, message: String) {
        super.init(frame: .zero)
        stateImageView.image = state.image
        messageLabel.text = message
        configureStackView()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Methods
    
    private func configureStackView() {
        axis = .vertical
        spacing = 8
        alignment = .center
        
        addArrangedSubview(stateImageView)
        addArrangedSubview(messageLabel)
    }
}
