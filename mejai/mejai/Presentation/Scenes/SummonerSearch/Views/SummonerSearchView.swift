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
            make.top.equalToSuperview().inset(Constants.Spacing.sm)
            make.leading.equalToSuperview().inset(Constants.Spacing.contentInset)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.xs)
            make.leading.equalToSuperview().inset(Constants.Spacing.contentInset)
        }
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.Spacing.lg)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.contentInset)
            make.height.equalTo(Constants.Height.searchBar)
        }
        
        addSubview(searchResultView)
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Constants.Spacing.md)
            make.leading.bottom.trailing.equalToSuperview().inset(Constants.Spacing.contentInset)
        }
    }
}
