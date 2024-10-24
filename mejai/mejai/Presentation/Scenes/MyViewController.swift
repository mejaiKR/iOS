//
//  MyViewController.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

import SnapKit

class MyViewController: BaseViewController<UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureDefaultNavigationBar(title: "타이틀", actionTitle: "다음")
//        configureLargeTitleNavigationBar(title: "mejai", font: .logo, image: .refresh)
//        configureLargeTitleNavigationBar(title: "설정", font: .heading1)
        
        let button = ConfirmButton(initialStateEnabled: false, title: "버튼")
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.horizontal)
            make.height.equalTo(Constants.Height.button)
            make.center.equalToSuperview()
        }
    }
}
