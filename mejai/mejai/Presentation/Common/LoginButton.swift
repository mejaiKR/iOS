//
//  LoginButton.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

final class LoginButton: UIButton {
    enum SocialType: String {
        case apple = "Apple"
        case google = "Google"
        
        var image: UIImage {
            switch self {
            case .apple:    .apple
            case .google:   .google
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .apple:    .black
            case .google:   .white
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .apple:    .white
            case .google:   .black
            }
        }
        
        var borderColor: CGColor {
            switch self {
            case .apple:    UIColor.black.cgColor
            case .google:   UIColor.gray04.cgColor
            }
        }
    }
    
    // MARK: - Init
    
    init(socialType: SocialType) {
        super.init(frame: .zero)
        configureButton(with: socialType)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Methods
    
    private func configureButton(with socialType: SocialType) {
        setImage(socialType.image, for: .normal)
        setTitle("\(socialType.rawValue)로 계속하기", for: .normal)
        setTitleColor(socialType.textColor, for: .normal)
        titleLabel?.font = .title2
        backgroundColor = socialType.backgroundColor
        layer.borderWidth = 1
        layer.borderColor = socialType.borderColor
        layer.cornerRadius = 8
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
    }
}
