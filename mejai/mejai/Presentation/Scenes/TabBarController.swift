//
//  TabBarController.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

import SnapKit

final class TabBarController: UITabBarController {
    private enum Tab: CaseIterable {
        case home
        case settings
        
        var image: UIImage {
            switch self {
            case .home:     .homeUnselected
            case .settings: .settingsUnselected
            }
        }
        
        var selectedImage: UIImage {
            switch self {
            case .home:     .homeSelected
            case .settings: .settingsSelected
            }
        }
    }
    
    // MARK: - Components
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    // MARK: - Setup Methods
    
    private func setupTabBar() {
        tabBar.tintColor = .gray09
        tabBar.unselectedItemTintColor = .gray09
        tabBar.backgroundColor = .backgroundPrimary
        
        tabBar.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupViewControllers() {
        viewControllers = Tab.allCases.map { tab in
            let viewController: UIViewController
            
            switch tab {
            case .home:     viewController = ViewController()
            case .settings: viewController = ViewController()
            }
            
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: tab.image,
                selectedImage: tab.selectedImage
            )
            return UINavigationController(rootViewController: viewController)
        }
    }
}
