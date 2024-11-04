//
//  MainTabBarController.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

import SnapKit

final class MainTabBarController: UITabBarController {
    // MARK: - Components
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Configure Methods
    
    private func configureTabBar() {
        tabBar.tintColor = .gray09
        tabBar.unselectedItemTintColor = .gray09
        tabBar.backgroundColor = .backgroundPrimary
        
        tabBar.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
