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
        configureLargeTitleNavigationBar(title: "mejai", font: .logo, image: .refresh)
        configureDataSource()
        configureBindings()
    }
    
    // MARK: - Configure Methods
    
    private func configureDataSource() {
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
    
    private func configureBindings() {
        viewModel.state.homeViewState
            .sink { [weak self] state in
                self?.scrollView.isHidden = state == .error
                self?.errorView.isHidden = state == .success
            }
            .store(in: &cancellables)
        
        viewModel.state.summonerProfileViewModel
            .sink { [weak self] viewModel in
                self?.summonerProfileView.configure(with: viewModel)
            }
            .store(in: &cancellables)
        
        viewModel.state.rankTierCellViewModels
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
            }
            .store(in: &cancellables)
        
        viewModel.state.todayDayLogCellViewModels
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
            }
            .store(in: &cancellables)
        
        viewModel.state.todayPlayLogCellViewModels
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
                self?.todayPlayLogView.updateCollectionViewHeight(for: cellViewModels.count)
                self?.todayEmptyView.isHidden = !cellViewModels.isEmpty
                self?.todayDayLogCollectionView.isHidden = cellViewModels.isEmpty
                self?.todayPlayLogView.isHidden = cellViewModels.isEmpty
            }
            .store(in: &cancellables)
        
        viewModel.state.weekPlayLogCellViewModels
            .sink { [weak self] cellViewModels in
                self?.applySnapshot(with: cellViewModels)
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
    
    var summonerProfileView: SummonerProfileView {
        contentView.summonerProfileView
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
