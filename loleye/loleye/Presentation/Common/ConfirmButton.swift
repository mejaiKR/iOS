//
//  ConfirmButton.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

final class ConfirmButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Init
    
    init(initialStateEnabled: Bool = true, title: String) {
        super.init(frame: .zero)
        configureButton(with: title)
        isEnabled = initialStateEnabled
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Configure Methods
    
    private func configureButton(with title: String) {
        layer.cornerRadius = 8
        
        setTitle(title, for: .normal)
        setTitleColor(.gray00, for: .normal)
        titleLabel?.font = .title2
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? .primary : .disabled
    }
}
