//
//  ViewController.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLabels()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupLabels() {
        let labelsText = [
            ("mejai", UIFont.logo),
            ("Heading 1", UIFont.heading1),
            ("Heading 2", UIFont.heading2),
            ("Heading 3", UIFont.heading3),
            ("Title 1", UIFont.title1),
            ("Title 2", UIFont.title2),
            ("Title 3", UIFont.title3),
            ("Body 1", UIFont.body1),
            ("Body 2", UIFont.body2),
            ("Body 3", UIFont.body3),
            ("Caption 1", UIFont.caption1),
            ("Caption 2", UIFont.caption2)
        ]

        for (text, font) in labelsText {
            let label = UILabel()
            label.text = text
            label.applyTypography(with: font)
            label.textColor = .black
            stackView.addArrangedSubview(label)
        }
    }
}
