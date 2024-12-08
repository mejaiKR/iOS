//
//  SummonerSearchView.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class SummonerSearchView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = Strings.SummonerSearch.title
        label.applyTypography(with: .heading2)
        label.textColor = .gray09
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = Strings.SummonerSearch.descripton
        label.applyTypography(with: .body3)
        label.textColor = .gray04
        return label
    }()
    
    let searchBar = SearchBar()
    
    let searchResultView = SearchResultView()
    
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
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        addSubview(searchResultView)
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
