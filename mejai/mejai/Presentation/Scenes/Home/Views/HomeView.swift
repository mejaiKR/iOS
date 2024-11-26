//
//  HomeView.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Components
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let summonerProfileView = SummonerProfileView()
    
    let rankTierView = RankTierView()
    
    let todayView = TodayView()
    
    let weekView = WeekView()
    
    let errorView = StateView(state: .error, message: "뭔가 문제가 있어요\n다시 시도해주세요")
    
    let loadingIndicator = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        return indicator
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
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(rankTierView)
        rankTierView.snp.makeConstraints { make in
            make.top.equalTo(summonerProfileView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(todayView)
        todayView.snp.makeConstraints { make in
            make.top.equalTo(rankTierView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(weekView)
        weekView.snp.makeConstraints { make in
            make.top.equalTo(todayView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
