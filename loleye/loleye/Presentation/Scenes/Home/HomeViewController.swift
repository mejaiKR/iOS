//
//  HomeViewController.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import Combine
import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var rankTierDataSource: UICollectionViewDiffableDataSource<Int, RankTierCellViewModel>!
    private var todayDayLogDataSource: UICollectionViewDiffableDataSource<Int, TodayDayLogCellViewModel>!
    private var todayPlayLogDataSource: UICollectionViewDiffableDataSource<Int, TodayPlayLogCellViewModel>!
    private var weekPlayLogDataSource: UICollectionViewDiffableDataSource<Int, WeekPlayLogCellViewModel>!
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
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
        configureLargeTitleNavigationBar(title: Strings.appName, font: .logo, image: .refresh)
        setupDataSource()
        setupBindings()
        viewModel.send(.fetchSummoner)
    }
    
    // MARK: - Setup Methods
    
    private func setupDataSource() {
        rankTierDataSource = UICollectionViewDiffableDataSource<Int, RankTierCellViewModel>(
            collectionView: rankTierCollectionView,
            cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: RankTierCell.self
                )
                cell.configure(with: viewModel)
                return cell
            }
        )
        
        todayDayLogDataSource = UICollectionViewDiffableDataSource<Int, TodayDayLogCellViewModel>(
            collectionView: todayDayLogCollectionView,
            cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: TodayDayLogCell.self
                )
                cell.configure(with: viewModel)
                return cell
            }
        )
        
        todayPlayLogDataSource = UICollectionViewDiffableDataSource<Int, TodayPlayLogCellViewModel>(
            collectionView: todayPlayLogCollectionView,
            cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: TodayPlayLogCell.self
                )
                cell.configure(with: viewModel)
                return cell
            }
        )
        
        weekPlayLogDataSource = UICollectionViewDiffableDataSource<Int, WeekPlayLogCellViewModel>(
            collectionView: weekPlayLogCollectionView,
            cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: WeekPlayLogCell.self
                )
                cell.configure(with: viewModel)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // action
        actionButton?.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.refresh)
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.homeViewState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                
                scrollView.isHidden = state != .success
                errorView.isHidden = state != .error
                loadingIndicator.isHidden = state != .loading
                
                state == .loading ?
                loadingIndicator.startAnimating() :
                loadingIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.state.lastUpated
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                self?.lastUpdatedLabel.text = text
            }
            .store(in: &cancellables)
        
        viewModel.state.summonerProfileViewModel
            .receive(on: RunLoop.main)
            .sink { [weak self] viewModel in
                self?.summonerProfileView.configure(with: viewModel)
            }
            .store(in: &cancellables)
        
        viewModel.state.rankTierCellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
            }
            .store(in: &cancellables)
        
        viewModel.state.todayDayLogCellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
            }
            .store(in: &cancellables)
        
        viewModel.state.todayPlayLogCellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                
                applySnapshot(with: cellViewModels)
                todayPlayLogView.updateCollectionViewHeight(for: cellViewModels.count)
                todayEmptyView.isHidden = !cellViewModels.isEmpty
                todayDayLogCollectionView.isHidden = cellViewModels.isEmpty
                todayPlayLogView.isHidden = cellViewModels.isEmpty
            }
            .store(in: &cancellables)
        
        viewModel.state.weekPlayLogCellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
            }
            .store(in: &cancellables)
        
        viewModel.state.refreshLimit
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.showAlert(
                    title: "데이터 불러오기",
                    message: "데이터 불러오기는 1시간마다 가능해요\n잠시 후 다시 시도해주세요",
                    actionText: "확인"
                )
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Snapshot Methods
    
    private func applySnapshot(with cellViewModels: [RankTierCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RankTierCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellViewModels, toSection: 0)
        rankTierDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(with cellViewModels: [TodayDayLogCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, TodayDayLogCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellViewModels, toSection: 0)
        todayDayLogDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(with cellViewModels: [TodayPlayLogCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, TodayPlayLogCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellViewModels, toSection: 0)
        todayPlayLogDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(with cellViewModels: [WeekPlayLogCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, WeekPlayLogCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellViewModels, toSection: 0)
        weekPlayLogDataSource.apply(snapshot, animatingDifferences: false)
    }
}

private extension HomeViewController {
    var scrollView: UIScrollView {
        contentView.scrollView
    }
    
    var errorView: StateView {
        contentView.errorView
    }
    
    var loadingIndicator: UIActivityIndicatorView {
        contentView.loadingIndicator
    }
    
    var summonerProfileView: SummonerProfileView {
        contentView.summonerProfileView
    }
    
    var lastUpdatedLabel: UILabel {
        contentView.lastUpdatedLabel
    }
    
    var rankTierCollectionView: UICollectionView {
        contentView.rankTierView.collectionView
    }
    
    var todayDayLogCollectionView: UICollectionView {
        contentView.todayView.collectionView
    }
    
    var todayPlayLogView: TodayPlayLogView {
        contentView.todayView.todayPlayLogView
    }
    
    var todayEmptyView: StateView {
        contentView.todayView.emptyView
    }
    
    var todayPlayLogCollectionView: UICollectionView {
        contentView.todayView.todayPlayLogView.collectionView
    }
    
    var weekPlayLogCollectionView: UICollectionView {
        contentView.weekView.collectionView
    }
}
