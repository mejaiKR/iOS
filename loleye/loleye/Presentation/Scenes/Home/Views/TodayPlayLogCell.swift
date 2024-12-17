//
//  TodayPlayLogCell.swift
//  mejai
//
//  Created by 지연 on 11/1/24.
//

import UIKit

final class TodayPlayLogCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private lazy var circleView = createView(with: .secondary)
    
    private lazy var upperLine = createView(with: .gray01)
    
    private lazy var lowerLine = createView(with: .gray01)
    
    private let timeLabel = {
        let label = UILabel()
        label.applyTypography(with: .body3)
        label.textColor = .gray09
        return label
    }()
    
    private let resultLabel = {
        let label = UILabel()
        label.applyTypography(with: .body2)
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
            make.leading.equalToSuperview().inset(4)
        }
        
        contentView.addSubview(lowerLine)
        lowerLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(snp.centerY)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(4)
        }
        
        contentView.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(9)
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
    
    func configure(with viewModel: TodayPlayLogCellViewModel) {
        guard let startTime = extractTime(from: viewModel.startTime),
              let endTime = extractTime(from: viewModel.endTime)
        else { return }
        timeLabel.text = "\(startTime) ~ \(endTime)"
        resultLabel.text = viewModel.isWin ? "승리" : "패배"
        resultLabel.textColor = viewModel.isWin ? .primary : .disabled
        upperLine.isHidden = viewModel.isFirst
        lowerLine.isHidden = viewModel.isLast
    }
}

private extension TodayPlayLogCell {
    func createView(with color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    func extractTime(from timestamp: String) -> String? {
        // DateFormatter 설정
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SS" // 입력 형식
        
        // String -> Date 변환
        guard let date = formatter.date(from: timestamp) else {
            return nil
        }
        
        // 필요한 시간 형식으로 변환
        formatter.dateFormat = "HH:mm" // 출력 형식
        return formatter.string(from: date)
    }
}
