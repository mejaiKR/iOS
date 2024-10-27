//
//  RelationshipCell.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

final class RelationshipCell: UICollectionViewCell, Reusable {
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Components
    
    private let relationLabel = {
        let label = UILabel()
        label.applyTypography(with: .body2)
        return label
    }()
    
    private let checkmarkImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        layer.cornerRadius = Constants.Radius.sm
        layer.borderWidth = 1
        updateAppearance()
    }
    
    private func configureLayout() {
        contentView.addSubview(relationLabel)
        relationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Spacing.sm)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Layout.IconImage.normal)
            make.trailing.equalToSuperview().inset(Constants.Spacing.sm)
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? .secondary : .clear
        layer.borderColor = (isSelected ? UIColor.secondary : UIColor.gray02).cgColor
        relationLabel.textColor = isSelected ? .primary : .gray04
        checkmarkImageView.image = isSelected ? .checkmarkSelected : .checkmarkUnselected
    }
    
    func configure(with relationship: Relationship) {
        relationLabel.text = relationship.rawValue
    }
}
