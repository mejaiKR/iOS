//
//  SearchResultView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class SearchResultView: UIView {
    let emptyView = StateView(
        state: .empty,
        message: Strings.SummonerSearch.emptyMessage
    )
    
    let summonerProfileView = SummonerProfileView()
    
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
        addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(0 - Constants.Spacing.lg)
        }
        
        addSubview(summonerProfileView)
        summonerProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Layout.Component.summonerProfileView)
        }
    }
}
