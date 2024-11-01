//
//  HomeView.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let summonerProfileView = SummonerProfileView()
    
    private let rankTierView = RankTierView()
    
    private let todayView = TodayView()
    
    private let weekView = WeekView()
    
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
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.addSubview(summonerProfileView)
        summonerProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Spacing.sm)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
        
        contentView.addSubview(rankTierView)
        rankTierView.snp.makeConstraints { make in
            make.top.equalTo(summonerProfileView.snp.bottom).offset(Constants.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
        
        contentView.addSubview(todayView)
        todayView.snp.makeConstraints { make in
            make.top.equalTo(rankTierView.snp.bottom).offset(Constants.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
        
        contentView.addSubview(weekView)
        weekView.snp.makeConstraints { make in
            make.top.equalTo(todayView.snp.bottom).offset(Constants.Spacing.md)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
            make.bottom.equalToSuperview()
        }
    }
}
