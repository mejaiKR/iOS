//
//  RankTierView.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

final class RankTierView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "티어"
        label.applyTypography(with: .title3)
        label.textColor = .gray09
        return label
    }()
    
    let infoButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        button.tintColor = .gray03
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: RankTierCell.self)
        collectionView.backgroundColor = .backgroundSecondary
        collectionView.layer.cornerRadius = 20
        collectionView.delegate = self
        return collectionView
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
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
            make.top.leading.equalToSuperview()
        }
        
//        addSubview(infoButton)
//        infoButton.snp.makeConstraints { make in
//            make.width.height.equalTo(15)
//            make.centerY.equalTo(titleLabel)
//            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
//        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(collectionView).inset(12)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(collectionView)
        }
    }
}

extension RankTierView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
