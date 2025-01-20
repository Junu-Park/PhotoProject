//
//  TopicCollectionView.swift
//  PhotoProject
//
//  Created by 박준우 on 1/20/25.
//

import UIKit

class TopicCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width / 2, height: frame.height)
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = layout
        self.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        self.showsHorizontalScrollIndicator = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
