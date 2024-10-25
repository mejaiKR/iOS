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
            make.center.equalToSuperview()
        }
    }
}
