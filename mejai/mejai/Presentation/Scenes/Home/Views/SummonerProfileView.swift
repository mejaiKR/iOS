//
//  SummonerProfileView.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

final class SummonerProfileView: UIStackView {
    // MARK: - Components
    
    private lazy var relationLabel = createLabel("애인", font: .title2, color: .primary)
    
    private let summonerImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray02
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var summonerNameLabel = createLabel("김승종", font: .title2, color: .gray09)
    
    private lazy var tagLineLabel = createLabel("#과로사", font: .body1, color: .gray05)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        summonerImageView.layoutIfNeeded()
        summonerImageView.layer.cornerRadius = summonerImageView.frame.width / 2
    }
    
    // MARK: - Configure Methods
    
    private func configureStackView() {
        axis = .horizontal
        spacing = Constants.Spacing.Content.summonerStackViewSpacing
        alignment = .center
    }
    
    private func configureLayout() {
        [relationLabel, summonerImageView, summonerNameLabel, tagLineLabel, UIView()]
            .forEach { addArrangedSubview($0) }
        
        summonerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Layout.IconImage.small)
        }
    }
}

private extension SummonerProfileView {
    func createLabel(_ text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: font)
        label.textColor = color
        return label
    }
}
