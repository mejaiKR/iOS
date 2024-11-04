//
//  WeekPlayLogCell.swift
//  mejai
//
//  Created by 지연 on 11/1/24.
//

import UIKit

final class WeekPlayLogCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let dayLabel = {
        let label = UILabel()
        label.applyTypography(with: .caption2)
        label.textColor = .gray04
        return label
    }()
    
    private let backView = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    private let frontView = UIView()
    
    private let countLabel = {
        let label = UILabel()
        label.applyTypography(with: .caption1)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        backView.layer.cornerRadius = frame.width / 2
        frontView.layer.cornerRadius = frame.width / 2
    }
    
    // MARK: - Configure Methods
    
    private func configureCell() {
        backgroundColor = .clear
    }
    
    private func configureLayout() {
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(5)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.addSubview(frontView)
        frontView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(0)
        }
        
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(with viewModel: WeekPlayLogCellViewModel) {
        dayLabel.text = viewModel.day
        let count = viewModel.count
        if count > 0 {
            countLabel.text = String(count)
        }
        let height: Int
        switch count {
        case 0:
            frontView.backgroundColor = .gray01
            height = 0
        case 1...5:
            frontView.backgroundColor = .primary
            height = 24 + 8 * count
        default:
            frontView.backgroundColor = .tertiary
            height = 64
        }
        frontView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
}
