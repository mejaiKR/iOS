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
    }
    
    private func configureBindings() {
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
}

private extension HomeViewController {
    var summonerProfileView: SummonerProfileView {
        contentView.summonerProfileView
    }
    
    var rankTierCollectionView: UICollectionView {
        contentView.rankTierView.collectionView
    }
    
    var todayDayLogCollectionView: UICollectionView {
        contentView.todayView.collectionView
    }
}
