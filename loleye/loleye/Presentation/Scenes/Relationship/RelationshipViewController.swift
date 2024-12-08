//
//  RelationshipViewController.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Combine
import UIKit

protocol RelationshipViewControllerDelegate: AnyObject {
    func relationshipViewControllerDidFinish()
}

final class RelationshipViewController: BaseViewController<RelationshipView> {
    weak var delegate: RelationshipViewControllerDelegate?
    private let viewModel: RelationshipViewModel
    private var cancellables = Set<AnyCancellable>()
    private let relationships = Relationship.allCases
    
    // MARK: - Init
    
    init(viewModel: RelationshipViewModel) {
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
        configureDefaultNavigationBar(actionTitle: "완료")
        setupRelationshipCollectionView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupRelationshipCollectionView() {
        relationshipCollectionView.delegate = self
        relationshipCollectionView.dataSource = self
    }
    
    private func setupBindings() {
        // action
        actionButton?.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.save)
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.fetchResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                if result {
                    self?.delegate?.relationshipViewControllerDidFinish()
                } else {
                    self?.showAlert(
                        title: "오류",
                        message: "오류가 발생했어요\n다시 시도해주세요",
                        actionText: "확인"
                    )
                }
            }
            .store(in: &cancellables)
        
        viewModel.state.isRelationSet
            .receive(on: RunLoop.main)
            .sink { [weak self] isSet in
                self?.actionButton?.isEnabled = isSet
            }
            .store(in: &cancellables)
    }
}

extension RelationshipViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.send(.relationDidTap(relationships[indexPath.row]))
    }
}

extension RelationshipViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return relationships.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            for: indexPath,
            cellType: RelationshipCell.self
        )
        cell.configure(with: relationships[indexPath.row])
        return cell
    }
}

private extension RelationshipViewController {
    var relationshipCollectionView: UICollectionView {
        contentView.collectionView
    }
}
