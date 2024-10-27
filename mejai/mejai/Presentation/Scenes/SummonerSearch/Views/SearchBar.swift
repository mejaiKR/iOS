//
//  SearchBar.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class SearchBar: UIView {
    // MARK: - Components
    
    private let searchImageView = {
        let imageView = UIImageView()
        imageView.image = .search
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let searchTextField = {
        let textField = UITextField()
        textField.placeholder = Strings.SummonerSearch.searchPlaceholder
        textField.font = .body2
        textField.textColor = .gray09
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Methods
    
    private func configureView() {
        backgroundColor = .backgroundSecondary
        layer.cornerRadius = Constants.Radius.sm
    }
    
    private func configureLayout() {
        addSubview(searchImageView)
        searchImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Layout.IconImage.normal)
            make.leading.equalToSuperview().inset(Constants.Spacing.sm)
            make.centerY.equalToSuperview()
        }
        
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(Constants.Spacing.xs)
            make.trailing.equalToSuperview().inset(Constants.Spacing.sm)
            make.centerY.equalToSuperview()
        }
    }
}
