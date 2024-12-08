//
//  SearchResultView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class SearchResultView: UIView {
    let stateView = StateView()
    
    let summonerSearchResultView = SummonerSearchResultView()
    
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
        addSubview(stateView)
        stateView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-42)
        }
        
        addSubview(summonerSearchResultView)
        summonerSearchResultView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
    }
}
