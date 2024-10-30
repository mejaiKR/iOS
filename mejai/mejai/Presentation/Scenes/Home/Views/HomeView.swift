//
//  HomeView.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Components
    
    private let summonerProfileView = SummonerProfileView()
    
    private let rankTierView = TierView()
    
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
        addSubview(summonerProfileView)
        summonerProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Spacing.sm)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
        
        addSubview(rankTierView)
        rankTierView.snp.makeConstraints { make in
            make.top.equalTo(summonerProfileView.snp.bottom).offset(Constants.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
    }
}
