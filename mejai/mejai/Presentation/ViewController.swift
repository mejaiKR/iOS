//
//  ViewController.swift
//  mejai
//
//  Created by 지연 on 10/17/24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        let labels: [UILabel] = [
            createLabel(text: "Heading 1", font: .heading1),
            createLabel(text: "Heading 2", font: .heading2),
            createLabel(text: "Heading 3", font: .heading3),
            createLabel(text: "Title 1", font: .title1),
            createLabel(text: "Title 2", font: .title2),
            createLabel(text: "Title 3", font: .title3),
            createLabel(text: "Body 1", font: .body1),
            createLabel(text: "Body 2", font: .body2),
            createLabel(text: "Body 3", font: .body3),
            createLabel(text: "Caption 1", font: .caption1),
            createLabel(text: "Caption 2", font: .caption2)
        ]
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        
        view.addSubview(stackView)
        
        // Add constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = .gray09
        label.numberOfLines = 1
        return label
    }
}

