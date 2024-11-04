//
//  SummonerSearchResultView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

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
        label.text = "소환사이름"
        label.font = .body2
        return label
    }()
    
    private let tagLineLabel = {
        let label = UILabel()
        label.text = "#태그라인"
        label.font = .body3
        label.textColor = .gray05
        return label
    }()
    
    private let rankTierLabel = {
        let label = UILabel()
        label.text = "솔로 랭크 솔로 랭크 티어 | 자유 랭크 자유 랭크 티어"
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
        configureCell()
        configureLayout()
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
    
    // MARK: - Configure Methods
    
    private func configureCell() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        updateAppearance()
    }
    
    private func configureLayout() {
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
}
