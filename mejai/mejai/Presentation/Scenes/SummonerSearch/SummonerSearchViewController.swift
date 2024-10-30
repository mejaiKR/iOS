//
//  SummonerSearchViewController.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import Combine
import UIKit

protocol SummonerSearchViewControllerDelegate: AnyObject {
    func summonerSearchViewControllerDidFinish()
}

final class SummonerSearchViewController: BaseViewController<SummonerSearchView> {
    weak var delegate: SummonerSearchViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultNavigationBar(actionTitle: "다음")
        configureBindings()
    }
    
    // MARK: - Configure Methods
    
    private func configureBindings() {
        actionButton?.tapPublisher
            .sink { [weak self] in
                self?.delegate?.summonerSearchViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        let tapGesture = UITapGestureRecognizer()
        summonerProfileView.addGestureRecognizer(tapGesture)
        tapGesture.tapPublisher
            .sink { [weak self] _ in
                self?.summonerProfileView.isSelected.toggle()
            }
            .store(in: &cancellables)
    }
}

private extension SummonerSearchViewController {
    var summonerProfileView: SummonerProfileView {
        contentView.searchResultView.summonerProfileView
    }
}
