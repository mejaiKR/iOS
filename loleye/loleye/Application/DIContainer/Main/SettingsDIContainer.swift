//
//  SettingsDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class SettingsDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Controllers
    
    func makeSettingsViewController() -> SettingsViewController {
        return SettingsViewController()
    }
}
