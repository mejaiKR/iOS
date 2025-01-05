//
//  SearchBar.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import UIKit

final class SearchBar: UIView {
    // MARK: - Components
    
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
    
    let searchButton = {
        let button = UIButton()
        button.setImage(.search, for: .normal)
        return button
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
        layer.cornerRadius = 8
    }
    
    private func configureLayout() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalTo(searchButton.snp.leading).offset(-14)
            make.centerY.equalToSuperview()
        }
    }
}
