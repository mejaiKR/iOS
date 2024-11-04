//
//  AppDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Foundation

final class AppDIContainer {
    // MARK: - DIContainers of scenes
    
    func makeOnboardingDIContainer() -> OnboardingDIContainer {
        let dependencies = OnboardingDIContainer.Dependencies()
        return OnboardingDIContainer(dependencies: dependencies)
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        let dependencies = MainDIContainer.Dependencies()
        return MainDIContainer(dependencies: dependencies)
    }
}
