//
//  TierView.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

final class TierView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "티어"
        label.applyTypography(with: .title3)
        label.textColor = .gray09
        return label
    }()
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .backgroundSecondary
        view.layer.cornerRadius = Constants.Radius.lg
        return view
    }()
    
    private let rankTierStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    private let flexRankTierView = RankTierView()
    
    private let soloRankTierViw = RankTierView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        let spacing = containerView.frame.width - 1 - flexRankTierView.frame.width - soloRankTierViw.frame.width
        rankTierStackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.Spacing.sm)
            make.leading.trailing.equalToSuperview().inset(spacing / 4)
        }
    }
    
    // MARK: - Configure Methods
    
    private func configureLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.xs)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(Constants.Layout.Component.summonerProfileView)
        }
        
        [flexRankTierView, line, soloRankTierViw]
            .forEach { rankTierStackView.addArrangedSubview($0) }
        flexRankTierView.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        line.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalToSuperview()
        }
        
        soloRankTierViw.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        containerView.addSubview(rankTierStackView)
        rankTierStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
