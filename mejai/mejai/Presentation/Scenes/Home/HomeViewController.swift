//
//  HomeViewController.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLargeTitleNavigationBar(title: "mejai", font: .logo, image: .refresh)
    }
}
