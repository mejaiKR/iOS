//
//  RelationshipView.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

final class RelationshipView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = Strings.Relationship.title
        label.applyTypography(with: .heading2)
        label.textColor = .gray09
        label.numberOfLines = 2
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.Spacing.Content.cellSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: RelationshipCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Spacing.sm)
            make.leading.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.lg)
            make.leading.bottom.trailing.equalToSuperview().inset(Constants.Spacing.Content.padding)
        }
    }
}
