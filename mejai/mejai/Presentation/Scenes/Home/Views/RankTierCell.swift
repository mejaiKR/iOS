//
//  RankTierView.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

final class RankTierCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "자유 랭크"
        label.applyTypography(with: .caption2)
        label.textColor = .gray04
        return label
    }()
    
    private let tierImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray01
        return imageView
    }()
    
    private let tierLabel = {
        let label = UILabel()
        label.text = "PLATINUM II"
        label.applyTypography(with: .body3)
        label.textColor = .gray09
        return label
    }()
    
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(25)
        }
        
        addSubview(tierImageView)
        tierImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Layout.IconImage.small)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.xs)
            make.leading.equalToSuperview().inset(25)
        }
        
        addSubview(tierLabel)
        tierLabel.snp.makeConstraints { make in
            make.top.equalTo(tierImageView)
            make.leading.equalTo(tierImageView.snp.trailing).offset(Constants.Spacing.xs)
        }
    }
}
