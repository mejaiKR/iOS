//
//  SummonerProfileView.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

import Kingfisher

final class SummonerProfileView: UIStackView {
    // MARK: - Components
    
    private lazy var relationLabel = createLabel(font: .title2, color: .primary)
    
    private let summonerImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray02
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var summonerNameLabel = createLabel(font: .title2, color: .gray09)
    
    private lazy var tagLineLabel = createLabel(font: .body1, color: .gray05)
    
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
        spacing = 5
        alignment = .center
    }
    
    private func configureLayout() {
        [relationLabel, summonerImageView, summonerNameLabel, tagLineLabel, UIView()]
            .forEach { addArrangedSubview($0) }
        
        summonerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
    
    func configure(with viewModel: SummonerProfileViewModel) {
        relationLabel.text = viewModel.relationship
        summonerNameLabel.text = viewModel.name
        tagLineLabel.text = "#\(viewModel.tagLine)"
        guard let imageUrlString = viewModel.image else { return }
        summonerImageView.kf.setImage(with: URL(string: imageUrlString))
    }
}

private extension SummonerProfileView {
    func createLabel(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.applyTypography(with: font)
        label.textColor = color
        return label
    }
}
