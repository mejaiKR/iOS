//
//  TodayPlayLogView.swift
//  mejai
//
//  Created by 지연 on 11/1/24.
//

import UIKit

final class TodayPlayLogView: UIView {
    private let rowHeight = 34.0
    
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "로그"
        label.applyTypography(with: .caption2)
        label.textColor = .gray04
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: TodayPlayLogCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        return collectionView
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
        layer.cornerRadius = 20
    }
    
    private func configureLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(25)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(0)
            make.bottom.equalToSuperview().inset(11)
        }
    }
    
    func updateCollectionViewHeight(for count: Int) {
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(rowHeight * Double(count))
        }
    }
}

extension TodayPlayLogView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: rowHeight)
    }
}
