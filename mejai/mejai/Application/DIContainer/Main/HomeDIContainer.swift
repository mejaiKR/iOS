//
//  HomeDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class HomeDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    // MARK: - View Controllers
    
    func makeHomeViewController() -> HomeViewController {
        let viewModel = makeHomeViewModel()
        return HomeViewController(viewModel: viewModel)
    }
}
