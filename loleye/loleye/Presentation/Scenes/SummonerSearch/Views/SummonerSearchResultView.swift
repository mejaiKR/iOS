//
//  SummonerSearchResultView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

import Kingfisher

final class SummonerSearchResultView: UIView {
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Components
    
    private let profileStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let riotIDStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let summonerImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray02
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let summonerNameLabel = {
        let label = UILabel()
        label.font = .body2
        return label
    }()
    
    private let tagLineLabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .gray05
        return label
    }()
    
    private let rankTierLabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .gray04
        return label
    }()
    
    private let checkmarkImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        summonerImageView.layoutIfNeeded()
        summonerImageView.layer.cornerRadius = summonerImageView.frame.width / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        updateAppearance()
    }
    
    private func setupLayout() {
        [summonerImageView, summonerNameLabel, tagLineLabel, UIView()]
            .forEach { riotIDStackView.addArrangedSubview($0) }
        [riotIDStackView, rankTierLabel].forEach { profileStackView.addArrangedSubview($0) }
        
        summonerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        
        addSubview(profileStackView)
        profileStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalTo(checkmarkImageView.snp.leading).offset(-14)
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? .secondary : .clear
        layer.borderColor = (isSelected ? UIColor.secondary : UIColor.gray02).cgColor
        summonerNameLabel.textColor = isSelected ? .primary : .gray04
        checkmarkImageView.image = isSelected ? .checkmarkSelected : .checkmarkUnselected
    }
    
    // MARK: - Configure Methods
    
    func configure(with viewModel: SummonerSearchData) {
        summonerImageView.kf.setImage(with: URL(string: viewModel.profileIcon))
        summonerNameLabel.text = viewModel.summonerName
        tagLineLabel.text = viewModel.tag
        rankTierLabel.text = "솔로 랭크 \(viewModel.soloRankTier) | 자유 랭크 \(viewModel.flexRankTier)"
    }
}
