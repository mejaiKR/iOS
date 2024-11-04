//
//  TodayView.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

final class TodayView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "오늘"
        label.applyTypography(with: .title3)
        label.textColor = .gray09
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "00시 00분 기준"
        label.applyTypography(with: .caption1)
        label.textColor = .gray04
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: TodayDayLogCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        return collectionView
    }()
    
    let todayPlayLogView = TodayPlayLogView()
    
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
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        addSubview(todayPlayLogView)
        todayPlayLogView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(14)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension TodayView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 15) / 2
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
