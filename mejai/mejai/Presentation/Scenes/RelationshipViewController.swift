//
//  RelationshipViewController.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

final class RelationshipViewController: BaseViewController<RelationshipView> {
    private let relationships = Relationship.allCases
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultNavigationBar(actionTitle: "완료")
        configureRelationshipCollectionView()
    }
    
    // MARK: - Configure Methods
    
    private func configureRelationshipCollectionView() {
        relationshipCollectionView.delegate = self
        relationshipCollectionView.dataSource = self
    }
}

extension RelationshipViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: Constants.Layout.Component.relationshipCell
        )
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
