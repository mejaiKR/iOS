//
//  TodayLogCell.swift
//  mejai
//
//  Created by 지연 on 11/1/24.
//

import UIKit

final class TodayLogCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private lazy var circleView = createView(with: .secondary)
    
    private lazy var upperLine = createView(with: .gray01)
    
    private lazy var lowerLine = createView(with: .gray01)
    
    private let timeLabel = {
        let label = UILabel()
        label.text = "21:00 ~ 21:25"
        label.applyTypography(with: .body3)
        label.textColor = .gray09
        return label
    }()
    
    private let resultLabel = {
        let label = UILabel()
        label.text = "승리"
        label.applyTypography(with: .body2)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
    // MARK: - Configure Methods
    
    private func configureCell() {
        backgroundColor = .clear
    }
    
    private func configureLayout() {
        contentView.addSubview(upperLine)
        upperLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview()
            make.bottom.equalTo(snp.centerY)
            make.leading.equalToSuperview().inset(3.5)
        }
        
        contentView.addSubview(lowerLine)
        lowerLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(snp.centerY)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(3.5)
        }
        
        contentView.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(8)
            make.leading.centerY.equalToSuperview()
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(isFirst: Bool = false, isLast: Bool = false) {
        if isFirst {
            upperLine.isHidden = true
        } else if isLast {
            lowerLine.isHidden = true
        }
    }
}

private extension TodayLogCell {
    func createView(with color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}
