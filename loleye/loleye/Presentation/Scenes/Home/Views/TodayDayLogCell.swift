//
//  TodayDayLogCell.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import UIKit

final class TodayDayLogCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.applyTypography(with: .caption2)
        label.textColor = .gray04
        return label
    }()
    
    private let dataLabel = {
        let label = UILabel()
        label.applyTypography(with: .heading1)
        label.textColor = .primary
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
    
    // MARK: - Configure Methods
    
    private func configureCell() {
        backgroundColor = .backgroundSecondary
        layer.cornerRadius = 20
    }
    
    private func configureLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(25)
        }
        
        contentView.addSubview(dataLabel)
        dataLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func configure(with viewModel: TodayDayLogCellViewModel) {
        titleLabel.text = viewModel.cellType.rawValue
        dataLabel.text = String(viewModel.data)
    }
}
