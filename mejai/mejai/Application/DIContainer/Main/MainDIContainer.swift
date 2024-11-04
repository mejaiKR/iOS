//
//  MainDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import Foundation

final class MainDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - DI Containers
    
    func makeHomeDIContainer() -> HomeDIContainer {
        let dependencies = HomeDIContainer.Dependencies()
        return HomeDIContainer(dependencies: dependencies)
    }
    
    func makeSettingsDIContainer() -> SettingsDIContainer {
        let dependencies = SettingsDIContainer.Dependencies()
        return SettingsDIContainer(dependencies: dependencies)
    }
}
