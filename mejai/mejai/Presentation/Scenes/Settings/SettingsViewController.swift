//
//  SettingsViewController.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class SettingsViewController: BaseViewController<SettingsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLargeTitleNavigationBar(title: "설정", font: .heading1)
    }
}
