//
//  SummonerSearchViewController.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import Combine
import UIKit

protocol SummonerSearchViewControllerDelegate: AnyObject {
    func summonerSearchViewControllerDidFinish(summonerSearchData: SummonerSearchData)
}

final class SummonerSearchViewController: BaseViewController<SummonerSearchView> {
    weak var delegate: SummonerSearchViewControllerDelegate?
    private let viewModel: SummonerSearchViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let networkService = NetworkService(keychainService: KeychainService())
    
    // MARK: - Init
    
    init(viewModel: SummonerSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        configureDefaultNavigationBar(actionTitle: "다음")
        // 로그인 상태에서 다른 소환사 감시하기 플로우인 경우 백버튼 숨김
        if UserDataStorage.shared.isLogin {
            backButton?.isHidden = true
        }
    }
    
    private func setupBindings() {
        // action
        searchTextField.returnPublisher
            .compactMap { [weak self] in
                self?.searchTextField.text
            }
            .filter { !$0.isEmpty } // 빈 문자열 필터링
            .sink { [weak self] text in
                self?.viewModel.send(.search(text))
            }
            .store(in: &cancellables)
        
        searchButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                guard let text = searchTextField.text, !text.isEmpty else { return }
                viewModel.send(.search(text))
            }
            .store(in: &cancellables)

        searchTextField.textPublisher
            .filter { $0.isEmpty }
            .dropFirst()
            .sink { [weak self] text in
                self?.viewModel.send(.textFieldDidClear)
            }
            .store(in: &cancellables)
        
        actionButton?.tapPublisher
            .sink { [weak self] in
                guard let self = self,
                      let summonerSerachData = viewModel.summonerSearchData
                else { return }
                delegate?.summonerSearchViewControllerDidFinish(
                    summonerSearchData: summonerSerachData
                )
            }
            .store(in: &cancellables)
        
        let tapGesture = UITapGestureRecognizer()
        summonerSearchResultView.addGestureRecognizer(tapGesture)
        tapGesture.tapPublisher
            .sink { [weak self] _ in
                self?.summonerSearchResultView.isSelected.toggle()
                self?.viewModel.send(.resultViewDidTap)
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.summonerSearchViewState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .initial:
                    summonerSearchResultView.isHidden = true
                    emptyView.isHidden = true
                case .success:
                    summonerSearchResultView.isHidden = false
                    emptyView.isHidden = true
                case .failure:
                    summonerSearchResultView.isHidden = true
                    emptyView.isHidden = false
                    emptyView.configure(
                        state: .empty,
                        message: Strings.SummonerSearch.emptyMessage
                    )
                case .invalidInput:
                    summonerSearchResultView.isHidden = true
                    emptyView.isHidden = false
                    emptyView.configure(
                        state: .error,
                        message: Strings.SummonerSearch.invalidInputMessage
                    )
                }
            }
            .store(in: &cancellables)
        
        viewModel.state.summonerSearchData
            .receive(on: RunLoop.main)
            .sink { [weak self] searchData in
                self?.summonerSearchResultView.configure(with: searchData)
            }
            .store(in: &cancellables)
        
        viewModel.state.isSummonerSet
            .receive(on: RunLoop.main)
            .sink { [weak self] isSet in
                self?.actionButton?.isEnabled = isSet
            }
            .store(in: &cancellables)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension SummonerSearchViewController {
    var searchTextField: UITextField {
        contentView.searchBar.searchTextField
    }
    
    var searchButton: UIButton {
        contentView.searchBar.searchButton
    }
    
    var summonerSearchResultView: SummonerSearchResultView {
        contentView.searchResultView.summonerSearchResultView
    }
    
    var emptyView: StateView {
        contentView.searchResultView.stateView
    }
}
