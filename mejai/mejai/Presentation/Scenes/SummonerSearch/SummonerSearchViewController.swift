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
    
    let networkService = NetworkService(keychainService: KeychainService())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultNavigationBar(actionTitle: "다음")
        configureBindings()
        
        let target = SummonerAPI.getSummonerSearch(summonerName: "hide on bush", tag: "KR1")
        networkService.request(target, responseType: SummonerSearchResponse.self)
            .sink { completion in
                switch completion {
                case .finished:
                    print("ok")
                case .failure(let error):
                    print("error", error)
                }
            } receiveValue: { result in
                print(result)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Configure Methods
    
    private func configureBindings() {
        actionButton?.tapPublisher
            .sink { [weak self] in
                self?.delegate?.summonerSearchViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        let tapGesture = UITapGestureRecognizer()
        summonerSearchResultView.addGestureRecognizer(tapGesture)
        tapGesture.tapPublisher
            .sink { [weak self] _ in
                self?.summonerSearchResultView.isSelected.toggle()
            }
            .store(in: &cancellables)
    }
}

private extension SummonerSearchViewController {
    var summonerSearchResultView: SummonerSearchResultView {
        contentView.searchResultView.summonerSearchResultView
    }
}
